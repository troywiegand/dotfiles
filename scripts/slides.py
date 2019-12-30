##SCRIPT TO DOWNLOAD ALL FILES FROM A CANVAS SITE TO YOUR MACHINE
##MINE I HAVE FURTHER SPECIFIED TO ~/ButlerJunk
##use it like:
##python3 slides.py <courseid> <TARGETDIR>
import http.client
import simplejson
from urllib.request import urlopen, urlretrieve
import sys

conn = http.client.HTTPSConnection("butler.instructure.com")

payload = "------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"wiki_page[title]\"\r\n\r\nHello\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"wiki_page[body]\"\r\n\r\n <h1> ugh </h1>\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"wiki_page[published]\"\r\n\r\ntrue\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--"
##Included example token CANVAS.toke.example
token=open("CANVAS.token","r").read()
headers = {
    'content-type': "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
    'authorization': token
    }

courseid=sys.argv[1]
DIR=sys.argv[2]
conn.request("GET", "/api/v1/courses/"+str(courseid)+"/files?per_page=1000&sort=updated_at&order=desc", payload, headers)

res = conn.getresponse()
data = res.read()

jsonResult = simplejson.loads(data)

for file in jsonResult:
    print(file)
    filename=file["filename"]
    fileid=file["id"]

    payload = ""
    headers = {
    'content-type': "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
    'authorization': "Bearer 12258~Jc2f9s26OCIPtaQ1oGyOvmQ0OHQI7xtujm62a4gCv44dbFHVwZ4xo80XZHozEXIl",
    }

    conn.request("GET", "/api/v1/files/"+str(fileid)+"/public_url", payload, headers)

    res = conn.getresponse()
    data = res.read()

    public_url = simplejson.loads(data)["public_url"]

    print(filename)
    print(public_url)
    urlretrieve(public_url,"/home/troy/repos/ButlerJunk/"+DIR+"/"+filename)
