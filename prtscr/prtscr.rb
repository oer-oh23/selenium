#! ruby -Ku
#character code : UTF-8

#to use DateTime class
require "date"

#to use selenium-webdirver
require 'selenium-webdriver'

#clear screen
puts "\e[H\e[2"

#variables manage
class Vars

	#to reaccess to variables
	attr_accessor :t_int, :t_st, :t_max, :t_current, :b_soft, :b_url, :c_st, :c_ref, :c_current, :s_path, :s_name

	#initialize
	def initialize(saveto)

		@t_int = 1
		@t_st = 0
		@t_max = 5
		@t_current = 0

		@c_st = 0
		@c_ref = 3
		@c_current = 0

		@s_path = saveto

		@s_name = "#{@c_current}-#{@t_current}sec.png"

		@b_soft = "chrome"
		@b_url = "https://www.goo.ne.jp/"

	end
	def reload
		@s_name = "#{@c_current}-#{@t_current}sec.png"
	end
	def shvars

		print("time\n")
		print("interval\n")
		p @t_int
		print("start\n")
		p @t_st
		print("maximum\n")
		p @t_max

		print("\n")
		print("refresh count\n")
		p @c_ref

		print("\n")
		print("path\n")
		puts @s_path

		print("brower\n")
		p @b_soft
		print("url\n")
		p @b_url
		print("\n")
		print("\n")
		print("press return to continue ...\n")
	end
end

#status manage
class Status
	attr_accessor :status
	def initialize()
		@status=1
	end
	def disp
		case @status
			when 1 then
				print("[_]")
			when 2 then
				print("[x]")
			when 3 then
				print("[!]")
			else
				print("[?(st_no:#{st})]")
		end
	end
end

module Exp
	def self.settings
		print("<settings>\n")
		print("press \"r\" to reset settings\n")
		print("press \"d\" to display settings\n")
		print("press \"s\" to set options\n")
		print("press \"c\" to continue\n")
	end
	def self.set_t_max
		print("enter integer (sec)\n")
		print("to set maximum waiting time.\n")
	end
	def self.set_t_start
		print("enter integer (sec)\n")
		print("to set count start time.\n")
	end
	def self.set_t_interval
		print("enter integer (sec)\n")
		print("to set interval time.\n")
	end
	def self.set_url
		print("enter url\n")
		print("to set url.\n")
	end
	def self.set_browser
		print("enter browser name on this list.\n")
		#print("select driver\n")
		print("chrome\n")
		print("firefox\n")
		print("ie\n")
		print("edge\n")
		print("safari\n")
		#print("to set browser.\n")
	end
	def self.set_refleshcount
		print("enter integer \n")
		print("to set reload count.\n")
	end
end

#------------------------------------------------------------
puts "\e[H\e[2J"

path = "./screenshot_#{DateTime.now.strftime('%Y%m%d%H%M%S')}/"
vars = Vars.new(path)

#user interface?
while true do

	# clear screen
	puts "\e[H\e[2J"

	Exp.settings
	disp_settings = gets.chomp
	#p disp_settings

	# clear screen
	puts "\e[H\e[2J"

	puts "------------------------------------------------------------"

	case disp_settings
		when "r" then
			#Re initialize to set default
			vars=Vars.new(path)

		when "d" then
			p path
			#p vars.s_path
			#p vars.s_name
			vars.shvars
			gets

		when "s" then
			Exp.set_t_max
			vars.t_max = gets.to_i
			Exp.set_t_start
			vars.t_st = gets.to_i
			Exp.set_t_interval
			vars.t_int = gets.to_i
			Exp.set_url
			vars.b_url=gets.chomp
			Exp.set_browser
			vars.b_soft = gets.chomp
			Exp.set_refleshcount
			c_ref = gets.to_i

		when "c" then
			break

		else
	end
end





#select driver
driver = Selenium::WebDriver.for :"#{vars.b_soft}"

#window maximize
driver.manage().window().maximize();

#url
driver.navigate.to "#{vars.b_url}"

vars.c_current = vars.c_st
vars.t_current = vars.t_st

while vars.c_current < vars.c_ref do
	vars.t_current = vars.t_st
	while vars.t_current <= vars.t_max do
		vars.reload
		print("waitting #{vars.t_current}sec    ")
		if vars.t_st <= vars.t_current then
			print("save as #{vars.s_path}#{vars.s_name}\n")
			#print("save as #{path}#{name}\n")
			#make dir
			FileUtils.mkdir_p(vars.s_path) unless FileTest.exists?(vars.s_path)
			#FileUtils.mkdir_p(path) unless FileTest.exists?(path)
			#take prtscr
			driver.save_screenshot(vars.s_path+vars.s_name)
			#driver.save_screenshot(path+name)
		else
			print("\n")
		end
		sleep(vars.t_int)
		vars.t_current += vars.t_int
	end

	driver.navigate.refresh
	vars.c_current += 1
end


#close browser
driver.quit
print("press enter to quit")
gets
