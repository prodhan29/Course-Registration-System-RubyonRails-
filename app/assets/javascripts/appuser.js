
var get_results = function(id){

    var elements = document.getElementsByClassName("cgpa");
    var cgpa_list = [];
    for(var i=0 ;i<elements.length;i++){
        if(0<elements[i].value && elements[i].value<=4 )
            cgpa_list.push(elements[i].value);
        else alert("gpa is not valid");
    }
    console.log(cgpa_list);
    $.post("/appuser/submit_result",{id: id, cgpa_list: cgpa_list},function(){
        console.log("successfully sent !!");
    });

}