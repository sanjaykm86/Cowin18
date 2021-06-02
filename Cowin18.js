// const childProcess = require('child_process').spawn
// const powershell = childProcess('powershell.exe',['.\\Cowin.ps1'])
// powershell.stdout.on("data",function(data){
//     console.log("Powershell data : "+data)
// })
// powershell.stderr.on("data",function(data){
//     console.log("Powershell Errors: " + data);
// });
// powershell.on("exit",function(){
//     console.log("Powershell Script finished");
// });
// powershell.stdin.end(); //end input

const shell = require('node-powershell');
// let ps = new shell('./Cowin18.ps1')

let ps = new shell({
  executionPolicy: 'Unrestricted',
  noProfile: true
});

ps.addCommand('echo node-powershell')
ps.addCommand('./Cowin.ps1')

ps.invoke().then(output => {
  console.log(output);
}).catch(err => {
  console.log(err);
  ps.dispose();
});
// ps.on("error", err => {
//   console.error(err);
// });

// // Stdout
// ps.on("output", data => {
//   console.log(data);
// });

// // Stderr
// ps.on("error-output", data => {
//   console.error(data);
// });