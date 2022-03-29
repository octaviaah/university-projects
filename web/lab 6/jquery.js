function compareNumbers(a, b) {
    if (a > b)
        return 1;
    else if (a < b)
        return -1;
    else return 0;
}

function sortTableTextOrNumber(n, a, b) {
    if (isNaN($('td:eq(' + n + ')', a).text()))
        return $('td:eq(' + n + ')', a).text().localeCompare($('td:eq(' + n + ')', b).text());
    else return compareNumbers(parseInt($('td:eq(' + n + ')', a).text()), parseInt($('td:eq(' + n + ')', b).text()));
}


function sortTable(n) {
    const table = $('#tableSort');
    const header = $('th').get(n);
    var direction = header.className;
    table.find('tbody tr').sort(function (a, b) {
        if (direction === 'ascending') {
            return sortTableTextOrNumber(n, a, b);
        } else {
            return sortTableTextOrNumber(n, b, a);
        }
    }).appendTo(table);

    if (direction === 'ascending')
        header.className = header.className.replace("ascending", "descending");
    else
        header.className = header.className.replace("descending", "ascending");
}

function swapColumns(n) {
    if (n === 4) {
        $('tbody tr td:nth-child(4)').each(function (i, e) {
            var aux = $(e).clone();
            var aux2 = ($(e).prev().prev().prev()).clone();
            ($(e).prev().prev().prev()).replaceWith(aux);
            $(e).replaceWith(aux2);

        });
        $('thead tr th:nth-child(4)').each(function (i, e) {
            var aux = $(e).clone();
            var aux2 = ($(e).prev().prev().prev()).clone();
            ($(e).prev().prev().prev()).replaceWith(aux);
            $(e).replaceWith(aux2);

        });
    } else {
        $('tbody tr td:nth-child(' + (n + 1) + ')').each(function (i, e) {
            $(e).insertBefore($(e).prev());
        });
        $('thead tr th:nth-child(' + (n + 1) + ')').each(function (i, e) {
            $(e).insertBefore($(e).prev());
        });
    }
}