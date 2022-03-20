function sortTable(n) {
    var table, rows, i, x, y, switchNow, toSwitch, direction, first = -1;
    table = document.getElementById("tableSort");
    switchNow = true;
    direction = "ascending";
    while (switchNow) {
        switchNow = false;
        rows = table.rows;
        for (i = 1; i < (rows.length - 1); i++) {
            toSwitch = false;
            x = rows[i].getElementsByTagName("td")[n];
            y = rows[i + 1].getElementsByTagName("td")[n];
            if (direction === "ascending") {
                if (Number.isNaN(Number(x.innerHTML)) && Number.isNaN(Number(y.innerHTML))) {
                    if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                        toSwitch = true;
                        break;
                    }
                } else if (Number(x.innerHTML) > Number(y.innerHTML)) {
                    toSwitch = true;
                    break;
                }
            } else if (direction === "descending") {
                if (Number.isNaN(Number(x.innerHTML)) && Number.isNaN(Number(y.innerHTML))) {
                    if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                        toSwitch = true;
                        break;
                    }
                } else if (Number(x.innerHTML) < Number(y.innerHTML)) {
                    toSwitch = true;
                    break;
                }
            }
        }
        if (toSwitch) {
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            first = 1;
            switchNow = true;
        } else {
            if (first === -1 && direction === "ascending") {
                direction = "descending";
                switchNow = true;
            }
        }
    }
}