
var course_change =  function(e){

    var ob = {
        semester : document.getElementById("semester_id").value
    }
    server_call("/changecourse", ob);

}

var submit_registration =  function(){

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
    var ob = {
        semester : document.getElementById("semester_id").value,
        courses  : courses
    }
    server_call("/regsubmit",ob)

}

var server_call = function(path, ob){

    $.post(path, ob,function(){
        console.log("successfully sent");
    })
}
