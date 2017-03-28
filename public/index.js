$(document).ready(function () {
    var user = "";

    $(function () {
        $("#greeting").append(" " + user);
    })
    // $("#home").hide();
    // $("#name").hide();
    // $("#searchResult").hide();


    $("#signup").submit(function () {
        var $form = $(this),
            name = $form.find("input[id='username']").val();
        $.ajax({
            method: "POST",
            url: "/api/users",
            async: false,
            data: {name: name, utid: 1},
            statusCode: {
                200: function (response) {
                    window.location.href = "/home.html";
                    console.log("POK", JSON.stringify(response))
                },
                400: function (response) {
                    window.location.href = "/welcome.html";
                }
            }

        }).done(function () {
            window.location.href = "/home.html";
        });
        // .done(function( result ) {
        //     console.log("THE DONE RES", JSON.stringify(result))
        //     user = result.data.name;
        //     // location.href("home.html");
        //     // document.location.replace("home.html");
        //     // $("#greeting").append(" " + user);
        // })
    });

    // $("#signup").submit(function(){
    //     var $form = $( this ),
    //     name = $form.find( "input[id='username']" ).val()
    //     $.ajax({
    //       method: "POST",
    //       url: "/api/users",
    //       data: { name: name, utid: 1 }
    //     })
    //     .done(function( result ) {
    //         user = result.data.name;
    //         $("#welcome").hide();
    //         $("#home").show();
    //         $("#greeting").append(" " + user);
    //     })
    // });


    $("#login").submit(function () {
        var $form = $(this),
            name = $form.find("input[id='loginname']").val()
        $.ajax({
            method: "POST",
            url: "/api/login",
            data: {name: name}
        })
            .done(function (result) {
                user = result.data.name;
                window.location.href('../home.html');
                $("#greeting").append(" " + user);
            })
    });

    function searchName() {
        document.getElementById("content").innerHTML = '<object type="text/html" data="home.html" ></object>'
    }

    function searchIngredients() {
        $.ajax({
            method: "GET",
            url: "/api/ingredients"
        })
            .done(function (result) {

            })
    }

    // $('.list-group').on('click', '.list-group-item', function(e) {
    //     var $this = $(this);
    //     var href = $this.attr('href');
    //     $("#home").hide();
    //     $(href).show();
    // });

    $("#nameRecipe").submit(function () {
        var $form = $(this),
            name = $form.find("input[id='recipeName']").val()
        $.ajax({
            method: "POST",
            url: "/api/recipes/name",
            data: {name: name}
        })
            .done(function (result) {
                $("#name").hide();
                $("#searchResult").show();
                // $(".recipeResult").append('<p>hi</p>')
                $.each(result.data, function (i, value) {
                    $(".recipeResult").append('<a href="#" class="list-group-item list-group-item-action">' + value.name + '</a>')
                });

            })
    })


});