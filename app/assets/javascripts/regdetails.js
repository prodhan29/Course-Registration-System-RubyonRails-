var user_id = -1;

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
var change_user_role =function(event){

    user_id = event.target.id;
    document.getElementById("user_email").innerHTML = event.target.innerHTML;
    $("#roleModal").modal("show");
}

var change_role =function(event){

    console.log( document.getElementById("user_role").value );
    ob ={
        id: user_id,
        role: document.getElementById("user_role").value
    }
    server_call("/appuser/update_role",ob);
}
var server_call = function(path, ob){

    $.post(path, ob,function(){
        console.log("successfully sent");
    })
}
