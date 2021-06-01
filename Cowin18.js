const childProcess = require('child_process').spawn
const powershell = childProcess('powershell.exe',['.\\Cowin.ps1'])
powershell.stdout.on("data",function(data){
    console.log("Powershell data : "+data)
})
powershell.stderr.on("data",function(data){
    console.log("Powershell Errors: " + data);
});
powershell.on("exit",function(){
    console.log("Powershell Script finished");
});
powershell.stdin.end(); //end input