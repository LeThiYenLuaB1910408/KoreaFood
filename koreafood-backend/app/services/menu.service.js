const { log } = require("console");
const { ObjectId } = require("mongodb");

class MenuService {
    constructor(client) {
        this.Menu = client.db().collection("dish");
    }

    async getAll() {
        const result = await this.Menu.find({})
        return await result.toArray();
    }

    async getMenu(loai) {
        const result = await this.Menu.find({id_loai_mon_an: loai})
        return await result.toArray();
    }
    async delete(id) {
        const result = await this.Menu.findOneAndDelete({ _id: id })
        return result.ok;
    }
    async update(id, files, payload) {
        const filter = {
            _id: id
        };
        console.log(payload);
        let result;
        if (files != null) {
            const fs = require('fs');
            let folderPath = "D:\\LVTN\\koreafood-frontend\\src\\assets\\images";
            try {
                if (!fs.existsSync(folderPath)) {
                    fs.mkdirSync(folderPath);
                }
            } catch (err) {
                console.error(err);
            }
            let path = '';
            if (payload.id_loai_mon == 'L01') {
                path = 'Do_An'
            } else if (payload.id_loai_mon == 'L02') {
                path = 'Do_Uong'
            } else {
                path = 'Do_An/Mon_Them'
            }
            files.file.mv(`${folderPath}/${path}/${files.file.name}`, function (err) {
                if (err) {
                    console.log(err)
                    return res.status(500).send({ msg: "Error occured" });
                }
            });
            result = await this.Menu.findOneAndUpdate(
                filter,
                {
                    $set: {
                        ten_mon_an: payload.ten_mon,
                        id_loai_mon_an: payload.id_loai_mon,
                        trang_thai_mon_an: Number(payload.trang_thai_mon_an),
                        gia_mon_an: Number(payload.gia),
                        hinh_anh_mon_an: `${path}/${files.file.name}`
                    }
                },
                {
                    returnDocument: "after"
                }
            );

        }
        else {
            result = await this.Menu.findOneAndUpdate(
                filter,
                {
                    $set: {
                        ten_mon_an: payload.ten_mon,
                        id_loai_mon_an: payload.id_loai_mon,
                        gia_mon_an: Number(payload.gia),
                        trang_thai_mon_an: Number(payload.trang_thai_mon_an),
                    }
                },
                {
                    returnDocument: "after"
                }
            );
        }
        return result.ok;
    }
    async addDish(file, payload) {
        const fs = require('fs');
        let folderPath = "D:\\LVTN\\koreafood-frontend\\src\\assets\\images";
        try {

            if (!fs.existsSync(folderPath)) {
                fs.mkdirSync(folderPath);
            }

        } catch (err) {
            console.error(err);
        }
        let path = '';
        if (payload.id_loai_mon == 'L01') {
            path = 'Do_An'
        } else if (payload.id_loai_mon == 'L02') {
            path = 'Do_Uong'
        } else {
            path = 'Do_An/Mon_Them'
        }
        file.mv(`${folderPath}/${path}/${file.name}`, function (err) {
            if (err) {
                console.log(err)
                return res.status(500).send({ msg: "Error occured" });
            }
        });
        const result = await this.Menu.insertOne(
            {
                _id: payload.msp,
                ten_mon_an: payload.ten_mon,
                id_loai_mon_an: payload.id_loai_mon,
                gia_mon_an: Number(payload.gia),
                trang_thai_mon_an: Number(payload.trang_thai_mon_an),
                so_luong_ban_ra: 0,
                hinh_anh_mon_an: `${path}/${file.name}`
            }
        );
        return result.acknowledged;
    }
}

module.exports = MenuService;