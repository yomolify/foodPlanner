$(document).ready(function() {
    var user = "";
    $("#home").hide();

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
            $("#welcome").hide();
            $("#home").show();
            $("#greeting").append(" " + user);
        })
    });
});