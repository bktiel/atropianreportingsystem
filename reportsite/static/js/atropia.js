//for drop down items, on selection, update parent element
$(document).ready(function() {
    $('.dropdown-item').click(function () {
        var firstParent=$(this).closest('div')
        firstParent.siblings(".btn")[0].innerHTML=$(this).text()
    });
});

//utility JS getCookie function from django documentation
function getCookie(name) {
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            const cookie = cookies[i].trim();
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}

