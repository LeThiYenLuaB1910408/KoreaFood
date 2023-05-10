const { ObjectId } = require("mongodb");
const { log } = require("console");
const bcrypt = require("bcrypt");

class UserService {
    constructor(client) {
        this.User = client.db().collection("user");
    }

    async login(payload) {
        const result = await this.User.findOne(
            {
                'tai_khoan.ten_dang_nhap': payload.username,
            }
        )
        if (result) {
            // check user password with hashed password stored in the database
            const validPassword = await bcrypt.compare(payload.password, result.tai_khoan.mat_khau);
            if (validPassword) {
                return result;
            } else {
                return false;
            }
        }
        return false;
    }
    async getAll() {
        const result = await this.User.find({});
        return await result.toArray();
    }
    async getUser(id) {
        const result = await this.User.findOne({ _id: id });
        return result;
    };

    async addUser(payload) {
        const salt = await bcrypt.genSalt(10);
        let avatar;
        // now we set user password to hashed password
        const mat_khau = await bcrypt.hash(`@${payload.so_dien_thoai}`, salt);
        if (payload.gioi_tinh == 'Nữ') {
            avatar = 'user/NV01.jpg'
        } else {
            avatar = 'user/NV02.jpg'

        }
        const result = await this.User.insertOne({
            _id: payload.mnv,
            ho_ten: payload.ho_ten,
            cccd: payload.cccd,
            ngay_sinh: payload.ngay_sinh,
            gioi_tinh: payload.gioi_tinh,
            dia_chi: payload.dia_chi,
            so_dien_thoai: payload.so_dien_thoai,
            email: payload.email,
            hinh_anh_tai_khoan: avatar,
            tai_khoan: {
                ten_dang_nhap: `@${payload.so_dien_thoai}`,
                mat_khau: mat_khau,
                cap_quyen: payload.tai_khoan.cap_quyen,
                ngay_bat_dau_lam_viec: payload.tai_khoan.ngay_bat_dau_lam_viec
            }
        });
        if (result.acknowledged != null) {
            const nodemailer = require("nodemailer");

            var transporter = nodemailer.createTransport({
                service: "Gmail",
                auth: {
                    user: process.env.EMAIL,
                    pass: process.env.PASS,
                },
            });

            await transporter.sendMail({
                from: '"Lê Thị Yến Lụa"',
                to: payload.email,
                subject: "THÔNG TIN TÀI KHOẢN NHÂN VIÊN YL FOOD",
                text: "",
                html: `<p>Thông tin tài khoản đăng nhập ứng dụng YL Food của bạn là:</p>
                <p>Tên Đăng Nhập: <b>@${payload.so_dien_thoai}</b></p>
                <p>Mật Khẩu: <b>@${payload.so_dien_thoai}</b></p>
                <p>Vị Trí Công Việc: <b>${payload.tai_khoan.cap_quyen == 0 ? 'Nhân Viên Phục Vụ' : payload.tai_khoan.cap_quyen == 2 ? 'Thu Ngân' : 'Chủ Quán'}</b></p>
                <p><b>Lưu ý: </b>Bạn có thể thay đổi mật khẩu tài khoản.</p>`,
            });

        }

        return result;
    }
    async delete(id) {
        const result = await this.User.findOneAndDelete({ _id: id });
        return result.ok;
    }
    async update(id, payload) {
        const result = await this.User.findOneAndUpdate(
            { _id: id },
            {
                $set: payload
            }
        );
        return result.ok;
    }
    async updateAvar(file, id) {
        const fs = require('fs');
        let folderPath = "D:\\LVTN\\koreafood-frontend\\src\\assets\\images";
        let folderPathMobile = "D:\\LVTN\\korea_food\\assets\\images";
        try {
            if (!fs.existsSync(folderPath)) {
                fs.mkdirSync(folderPath);
            }
        } catch (err) {
            console.error(err);
        }
        file.mv(`${folderPath}/user/${file.name}`, function (err) {
            if (err) {
                console.log(err)
                return res.status(500).send({ msg: "Error occured" });
            }
        });
        file.mv(`${folderPathMobile}/user/${file.name}`, function (err) {
            if (err) {
                console.log(err)
                return res.status(500).send({ msg: "Error occured" });
            }
        });

        const result = await this.User.findOneAndUpdate(
            { _id: id },
            {
                $set: {
                    hinh_anh_tai_khoan: 'user/' + file.name
                }
            }
        )
        return result.ok;
    }
    async updatePassword(id, password) {
        const result = await this.User.findOne(
            { _id: id }
        )
        const validPassword = await bcrypt.compare(password.old, result.tai_khoan.mat_khau);
        if (validPassword) {
            const salt = await bcrypt.genSalt(10);
            const mat_khau = await bcrypt.hash(password.new, salt);
            const rs = await this.User.findOneAndUpdate(
                { _id: id },
                {
                    $set: {
                        'tai_khoan.mat_khau': mat_khau
                    }
                }
            )
            return rs.ok;
        } else {
            return 0;
        }
    }
    async updateProfile(id, payload) {
        const rs = await this.User.findOneAndUpdate(
            { _id: id },
            {
                $set: payload
            }
        )
        return rs.ok;
    }
}

module.exports = UserService;