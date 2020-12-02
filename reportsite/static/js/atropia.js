//for drop down items, on selection, update parent element
$(document).ready(function() {
    $('.dropdown-item').click(function () {
        var firstParent=$(this).closest('div')
        firstParent.siblings(".btn")[0].innerHTML=$(this).text()
    });
});

