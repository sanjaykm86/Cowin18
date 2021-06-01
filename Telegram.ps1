
function SendMessagetoTelegram{
param(
$token,
$chatid,
$message
)



Invoke-WebRequest -Uri "https://api.telegram.org/bot$token/sendMessage?chat_id=$chatid&text=$message"
}


