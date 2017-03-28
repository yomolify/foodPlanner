$(document).ready(function() {
    var user = "";

    $(function(){
        $("#greeting").append(" " + user);
    })
    // $("#home").hide();
    // $("#name").hide();
    // $("#searchResult").hide();


    $("#signup").submit(function(){

        var $form = $( this ),
        name = $form.find( "input[id='username']" ).val()
        $.ajax({
          method: "POST",
          url: "/api/users",
          data: { name: name, utid: 1 }
        })
        .done(function( result ) {
            user = result.data.name;

            // document.location.replace("home.html");
            // $("#greeting").append(" " + user);
        })
    });

    $("#login").submit(function(){
        var $form = $( this ),
            name = $form.find( "input[id='loginname']" ).val()
        $.ajax({
            method: "POST",
            url: "/api/login",
            data: { name: name}
        })
            .done(function( result ) {
                user = result.data.name;
                window.location.href('../home.html');
                $("#greeting").append(" " + user);
            })
    });

    function searchName(){
        document.getElementById("content").innerHTML='<object type="text/html" data="home.html" ></object>'
    }

    function searchIngredients(){
        $.ajax({
            method: "GET",
            url: "/api/ingredients"
        })
            .done(function(result){

            })
    }

    // $('.list-group').on('click', '.list-group-item', function(e) {
    //     var $this = $(this);
    //     var href = $this.attr('href');
    //     $("#home").hide();
    //     $(href).show();
    // });

    $("#nameRecipe").submit(function(){
        var $form = $( this ),
            name = $form.find( "input[id='recipeName']" ).val()
        $.ajax({
            method: "POST",
            url: "/api/recipes/name",
            data: { name: name}
        })
        .done(function( result ) {
            $("#name").hide();
            $("#searchResult").show();
            // $(".recipeResult").append('<p>hi</p>')
            $.each(result.data, function(i, value){
                $(".recipeResult").append('<a href="#" class="list-group-item list-group-item-action">' +  value.name + '</a>')
            });

        })
    })


});