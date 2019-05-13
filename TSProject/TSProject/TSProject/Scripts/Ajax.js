function SearchCategory() {
    $.ajax({
        url: "/Category/Search",
        data: {page:1, categoryName: $("#txtCategoryName").val() },
        success: function (result) {
            $("#listCategory").html(result);
        }
    });
}

function SearchProduct() {
    $.ajax({
        url:"/Product/Search",
        data:{page:1, productName: $("#txtproductName").val() },
        success: function(result){
            $("#listProduct").html(result);
            }
        });
}
function SaveCategory() {
    $.ajax({
        url: "/Category/InsertCategory",
        data: { name: $("#txtCategoryNameInsert").val() },
        success: function (result) {
            if (result == 1) {
                alert("Thêm mới thành công");
            }
            else {
                alert("Thêm mới không thành công");
            }
        }
    });
}