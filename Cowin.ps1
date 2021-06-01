Clear-Host

$CurrDir = Split-Path $MyInvocation.MyCommand.Definition
."$CurrDir\Telegram.ps1"
#".C:\Users\Sanjay\OneDrive\CareerAndResume\StudyMaterials\Powershell\Scripts\Telegram.ps1"


#$token = "1841810592:AAEQPj7L8LJCVFWjpmUUxj2ng_hsxTucxqk"
$token = "1846882076:AAEHszLuFp_mDjtX0JAGYi_1PDzP-PTV_ew"
#$chatid = "-527151930"
$chatid = "-566310591"
$message = ""


$today = Get-Date -UFormat "%d/%m/%Y"
[int]$i = 295
#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
for($i -eq 295;$i -lt 309;$i++)
{
#$i.ToString()
[String]$url = "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=$i&date=$today"

$result = Invoke-WebRequest -Uri $url -Headers @{
"sec-ch-ua"="`" Not A;Brand`";v=`"99`", `"Chromium`";v=`"90`", `"Google Chrome`";v=`"90`""
  "Accept"="application/json, text/plain, */*"
  "sec-ch-ua-mobile"="?0"
  "User-Agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
  "Origin"="https://www.cowin.gov.in"
  "Sec-Fetch-Site"="cross-site"
  "Sec-Fetch-Mode"="cors"
  "Sec-Fetch-Dest"="empty"
  "Referer"="https://www.cowin.gov.in/"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="en-US,en;q=0.9,ml;q=0.8,te;q=0.7"
} 

$centres = $result.content | ConvertFrom-Json


foreach($centre in $centres)
{

foreach($session in $centres[0].centers[0].sessions)
{
if($session.min_age_limit -eq 18 -and $session.available_capacity -gt 0)
{

#Send-MailMessage -From 'sanjay@sreepadma.com' -To 'Sanjay <sanjaykmurali@gmail.com>' -Subject 'Sending the Attachment' -Body "Forgot to send the attachment. Sending now."  -Priority High -DeliveryNotificationOption OnSuccess, OnFailure -SmtpServer 'localhost' -Port 25
$message = $message +"Name : "+ $centre[0].centers[0].name + "`r`n"
$message = $message +"District : "+ $centre.centers[0].district_name+"`r`n"
$message = $message +"Block : "+$centres[0].centers[0].block_name+"`r`n"
$message = $message +"Sessions : "+"`r`n"
$message = $message +"Date : "+$session.date+"`r`n"
$message = $message +"Vaccine : "+$session.vaccine+"`r`n"
$message = $message+"Minimum Age Limit : "+$session.min_age_limit+"`r`n"
$message = $message +"Available Capacity : "+$session.available_capacity+"`r`n"
$message = $message +"Available Capacity for Dose 1 : "+$session.available_capacity_dose1+"`r`n"
$message = $message +"Available Capacity for Dose 2 : "+$session.available_capacity_dose2+"`r`n"
$message = $message +"Slots : "+ "`r`n"
foreach($slot in $session.slots)
{
$message = $message +$slot+ "`r`n"
}
$message = $message +"`r`n`r`n`r`n"
"Message is :"+$message
"Message length is :"+$message.Length
if([string]::IsNullOrEmpty($message)){"No slots available"}
else
{
SendMessagetoTelegram -token $token -chatid $chatid -message $message
}
}
}
#"Sessions : ",$centres[0].centers[0].sessions 
}
}
#SendMessagetoTelegram -token $token -chatid $chatid -message $message


