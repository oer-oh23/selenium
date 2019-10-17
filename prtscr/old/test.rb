#! ruby -Ku
#Set Character Code : UTF-8

#DateTimeクラスを使えるようにする
#to use DateTime class
require "date"

#Selenium-webdriver　を呼び出す
#to use selenium-webdriver
require 'selenium-webdriver'

#clear screen
puts "\e[H\e[2J"

#ドライバ選択
case driverno
when 1 then
	driver = Selenium::WebDriver.for :chrome
when 2 then
	driver = Selenium::WebDriver.for :firefox
when 3 then
	driver = Selenium::WebDriver.for :ie
when 4 then
	driver = Selenium::WebDriver.for :edge
when 5 then
	driver = Selenium::WebDriver.for :safari
end
