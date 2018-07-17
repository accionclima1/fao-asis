BASIC_GRAINS = {
    init: function(){
        $(document).on("ajax:success", function(event){
            [data, status, xhr] = event.detail;
            $("#container").html(xhr.responseText);
        });
        Rails.fire($("form")[0], 'submit');
        $("#main_class").on("change", function(event){
            var value = $(this).val();
            if(value == 'probabilidad'){
                $("#percentage-container").show();
                $("#periodSelect").hide();
                $('#period_type').prop('selectedIndex', 1);
            }else{
                $("#percentage-container").hide();
                $("#periodSelect").show();
            }
        });
    }
};