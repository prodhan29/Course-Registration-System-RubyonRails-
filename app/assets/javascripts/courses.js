var get_courses =function(){

    console.log("iiii");
    var ob = {
        id: document.getElementById("semester").value
    }
    $.post("/courses/semester_courses", ob, function(){
        console.log("successfull");
    })
}