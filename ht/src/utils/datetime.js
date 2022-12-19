/**
 * 转化为日期格式
 * @param value
 * @returns {string}
 */
function datetime(value) {
    if (value == 0) {
        return "-";
    }

    let dat = new Date(Number(value) * 1000);
    let year = dat.getFullYear(),
        month = dat.getMonth() + 1,
        day = dat.getDate();
    let hour = dat.getHours(),
        minute = dat.getMinutes(),
        second = dat.getSeconds();
    return (
        year +
        "-" +
        (month > 9 ? month : "0" + month) +
        "-" +
        (day > 9 ? day : "0" + day) +
        " " +
        (hour > 9 ? hour : "0" + hour) +
        ":" +
        (minute > 9 ? minute : "0" + minute) +
        ":" +
        (second > 9 ? second : "0" + second)
    );
}

// 本月第1天
function getFirstDayOfMonth() {
    let dat = new Date();
    let cur = new Date(dat.getFullYear(), dat.getMonth(), 1, 0, 0, 0, 0);
    return cur.toLocaleDateString().replaceAll("/", "-");
}

// 本月最后1天
function getLastDayOfMonth() {
    let dat = new Date();
    let cur = new Date(dat.getFullYear(), dat.getMonth() + 1, 1, 0, 0, 0, 0);
    cur.setDate(cur.getDate() - 1);
    return cur.toLocaleDateString().replaceAll("/", "-");
}

function datetime_ms(value) {
    if (value == 0) {
        return "-";
    }

    let dat = new Date(Number(value) / 1000);
    let year = dat.getFullYear(),
        month = dat.getMonth() + 1,
        day = dat.getDate();
    let hour = dat.getHours(),
        minute = dat.getMinutes(),
        second = dat.getSeconds();
    return (
        year +
        "-" +
        (month > 9 ? month : "0" + month) +
        "-" +
        (day > 9 ? day : "0" + day) +
        " " +
        (hour > 9 ? hour : "0" + hour) +
        ":" +
        (minute > 9 ? minute : "0" + minute) +
        ":" +
        (second > 9 ? second : "0" + second)
    );
}

module.exports = {
    datetime,
    getFirstDayOfMonth,
    getLastDayOfMonth,
    datetime_ms,
};
