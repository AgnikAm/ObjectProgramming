import unittest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.keys import Keys
import time

class UITestCase(unittest.TestCase):

    def setUp(self):
        service = Service(executable_path="chromedriver.exe")
        options = webdriver.ChromeOptions()
        options.add_argument('--headless')
        self.driver = webdriver.Chrome(service=service, options=options)
        self.driver.get("http://127.0.0.1:5000")
        self.driver.implicitly_wait(3)

    def tearDown(self):
        self.driver.quit()

    def test_title(self):
        self.assertEqual(self.driver.title, "Formularz kontaktowy")

    def test_header_visible(self):
        header = self.driver.find_element(By.TAG_NAME, "h1")
        self.assertTrue(header.is_displayed())
        self.assertEqual(header.text, "Kontakt")

    def test_name_input_exists(self):
        self.assertTrue(self.driver.find_element(By.ID, "name"))

    def test_email_input_exists(self):
        self.assertTrue(self.driver.find_element(By.ID, "email"))

    def test_textarea_exists(self):
        self.assertTrue(self.driver.find_element(By.ID, "message"))

    def test_submit_button_exists(self):
        btn = self.driver.find_element(By.ID, "submit-btn")
        self.assertTrue(btn.is_displayed())

    def test_link_exists(self):
        link = self.driver.find_element(By.ID, "external-link")
        self.assertTrue(link.is_displayed())

    def test_link_href_correct(self):
        link = self.driver.find_element(By.ID, "external-link")
        self.assertTrue(link.get_attribute("href").startswith("https://example.com"))

    def test_link_text(self):
        link = self.driver.find_element(By.ID, "external-link")
        self.assertEqual(link.text.strip(), "Zewnętrzny link")

    def test_clicking_link_opens_new_page(self):
        link = self.driver.find_element(By.ID, "external-link")
        self.assertTrue(link.get_attribute("href").startswith("https://"))

    def test_empty_form_submission_shows_error(self):
        self.driver.find_element(By.ID, "submit-btn").click()
        messages = self.driver.find_elements(By.CLASS_NAME, "error")
        self.assertTrue(any("Wszystkie pola są wymagane!" in msg.text for msg in messages))

    def test_missing_name(self):
        self.driver.find_element(By.ID, "email").send_keys("test@example.com")
        self.driver.find_element(By.ID, "message").send_keys("Hello")
        self.driver.find_element(By.ID, "submit-btn").click()
        messages = self.driver.find_elements(By.CLASS_NAME, "error")
        self.assertTrue(messages)

    def test_missing_email(self):
        self.driver.find_element(By.ID, "name").send_keys("Jan")
        self.driver.find_element(By.ID, "message").send_keys("Test")
        self.driver.find_element(By.ID, "submit-btn").click()
        messages = self.driver.find_elements(By.CLASS_NAME, "error")
        self.assertTrue(messages)

    def test_missing_message(self):
        self.driver.find_element(By.ID, "name").send_keys("Jan")
        self.driver.find_element(By.ID, "email").send_keys("test@example.com")
        self.driver.find_element(By.ID, "submit-btn").click()
        messages = self.driver.find_elements(By.CLASS_NAME, "error")
        self.assertTrue(messages)

    def test_spaces_only_submission(self):
        self.driver.find_element(By.ID, "name").send_keys(" ")
        self.driver.find_element(By.ID, "email").send_keys(" ")
        self.driver.find_element(By.ID, "message").send_keys(" ")
        self.driver.find_element(By.ID, "submit-btn").click()
        messages = self.driver.find_elements(By.CLASS_NAME, "error")
        self.assertTrue(messages)

    def test_valid_form_submission(self):
        self.driver.find_element(By.ID, "name").send_keys("Anna")
        self.driver.find_element(By.ID, "email").send_keys("anna@example.com")
        self.driver.find_element(By.ID, "message").send_keys("To jest test")
        self.driver.find_element(By.ID, "submit-btn").click()
        messages = self.driver.find_elements(By.CLASS_NAME, "success")
        self.assertTrue(any("została wysłana" in msg.text for msg in messages))

    def test_form_clears_after_submit(self):
        self.driver.find_element(By.ID, "name").send_keys("Anna")
        self.driver.find_element(By.ID, "email").send_keys("anna@example.com")
        self.driver.find_element(By.ID, "message").send_keys("To jest test")
        self.driver.find_element(By.ID, "submit-btn").click()
        time.sleep(1)
        self.assertEqual(self.driver.find_element(By.ID, "name").get_attribute("value"), "")

    def test_multiple_submissions(self):
        for i in range(2):
            self.driver.get("http://127.0.0.1:5000")
            self.driver.find_element(By.ID, "name").send_keys(f"User{i}")
            self.driver.find_element(By.ID, "email").send_keys(f"user{i}@example.com")
            self.driver.find_element(By.ID, "message").send_keys("Hello!")
            self.driver.find_element(By.ID, "submit-btn").click()
            messages = self.driver.find_elements(By.CLASS_NAME, "success")
            self.assertTrue(messages)

    def test_fields_accept_input(self):
        self.driver.find_element(By.ID, "name").send_keys("Jan Kowalski")
        self.driver.find_element(By.ID, "email").send_keys("jan@kowalski.pl")
        self.driver.find_element(By.ID, "message").send_keys("Wiadomość testowa")
        self.assertEqual(self.driver.find_element(By.ID, "name").get_attribute("value"), "Jan Kowalski")

    def test_tab_navigation(self):
        name = self.driver.find_element(By.ID, "name")
        name.send_keys(Keys.TAB)
        active = self.driver.switch_to.active_element
        self.assertEqual(active.get_attribute("id"), "email")

    def test_email_input_type(self):
        email = self.driver.find_element(By.ID, "email")
        self.assertEqual(email.get_attribute("type"), "email")

    def test_message_textarea_tag(self):
        message = self.driver.find_element(By.ID, "message")
        self.assertEqual(message.tag_name, "textarea")

    def test_placeholder_name(self):
        self.assertFalse(self.driver.find_element(By.ID, "name").get_attribute("placeholder"))

    def test_button_text(self):
        btn = self.driver.find_element(By.ID, "submit-btn")
        self.assertEqual(btn.text, "Wyślij")

    def test_external_link_target(self):
        link = self.driver.find_element(By.ID, "external-link")
        self.assertTrue(link.get_attribute("href"))

    def test_long_name_input(self):
        long_name = "a" * 100
        self.driver.find_element(By.ID, "name").send_keys(long_name)
        self.assertEqual(self.driver.find_element(By.ID, "name").get_attribute("value"), long_name)

    def test_invalid_email_format(self):
        self.driver.find_element(By.ID, "email").send_keys("not-an-email")
        self.driver.find_element(By.ID, "submit-btn").click()

    def test_form_with_html_tags(self):
        self.driver.find_element(By.ID, "name").send_keys("<script>")
        self.driver.find_element(By.ID, "email").send_keys("x@x.com")
        self.driver.find_element(By.ID, "message").send_keys("<b>bold</b>")
        self.driver.find_element(By.ID, "submit-btn").click()
        messages = self.driver.find_elements(By.CLASS_NAME, "success")
        self.assertTrue(messages)

    def test_refresh_after_submit(self):
        self.driver.find_element(By.ID, "name").send_keys("Refresh")
        self.driver.find_element(By.ID, "email").send_keys("r@r.com")
        self.driver.find_element(By.ID, "message").send_keys("Refresh test")
        self.driver.find_element(By.ID, "submit-btn").click()
        self.driver.refresh()
        self.assertEqual(self.driver.title, "Formularz kontaktowy")

    def test_blank_form_after_success(self):
        self.driver.find_element(By.ID, "name").send_keys("X")
        self.driver.find_element(By.ID, "email").send_keys("x@x.com")
        self.driver.find_element(By.ID, "message").send_keys("msg")
        self.driver.find_element(By.ID, "submit-btn").click()
        time.sleep(1)
        self.assertEqual(self.driver.find_element(By.ID, "name").get_attribute("value"), "")

if __name__ == "__main__":
    unittest.main()
