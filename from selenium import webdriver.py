from selenium import webdriver
from selenium.webdriver.chrome.options import Options
# 基本設定
options = Options()

# Chrome 位置
options.binary_location = "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe"

# webdriver 位置
driver = webdriver.Chrome('C:\\Users\\USER\\Documents\\NICK\\python\\chromedriver.exe')
driver = webdriver.Chrome(executable_path=webdriver_path, options=options)

# 前往 google
driver.get('https://google.com')
search = driver.find_element("name", "gLFyf gsfi")
search.send_keys("httpd")