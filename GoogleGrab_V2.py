from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options

chrome_options = Options()
chrome_options.add_argument("--window-size=1024x768")
chrome_options.add_argument("--headless")
chrome_options.add_argument('log-level=3')
driver = webdriver.Chrome(chrome_options=chrome_options)

def ask_google(query):
    # Search for query
    query = query.replace(' ', '+')
    driver.get('http://www.google.com/search?q=' + query)

    # Get text from Google answer box
    answer = driver.execute_script("return document.elementFromPoint(350, 230);").text

    try:
        answer += "\n" + driver.find_element_by_xpath('//div[@data-dobid="dfn"]/span').text
    except: pass

    return answer

while True:
    query = input("What do you want to search for? ")
    the_answer = ask_google(query)
    print(the_answer)

driver.close()
