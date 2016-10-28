
var course_change =  function(e){

    var ob = {
        semester : document.getElementById("semester_id").value
    }
    server_call("/changecourse", ob);

}

var submit_registration =  function(){

    var ob = {
        semester : document.getElementById("semester_id").value,
        courses  : get_course_calculation()
    }
    server_call("/regsubmit",ob)
}

var update_registration =function(){

    var ob = {
        semester : document.getElementById("semester_id").value,
        courses  : get_course_calculation()
    }
    server_call("/regdetails/update_reg",ob)
}

var get_course_calculation =function(){

    var ins = document.getElementsByTagName("input");
    var courses = [];

    for(i=0; i<ins.length; i++){

        if(ins[i].type.toLowerCase() == "checkbox"&& ins[i].checked){
            courses.push({
                id: ins[i].id,
                name: ins[i].name
            });
        }
    }
    return courses;

}
var server_call = function(path, ob){

    $.post(path, ob,function(){
        console.log("successfully sent");
    })
}
