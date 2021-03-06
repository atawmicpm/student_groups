require 'debugger'
require_relative '../app/models/group'

a = Mechanize.new
a.get('http://socrates.devbootcamp.com/login') do |page|
	my_page = page.form_with(:action => '/sessions') do |f|
		f.email  			= ENV['SOCRATES_USER']
		f.password    = ENV['SOCRATES_PASS']
	end.click_button
end

cohorts = [15,18]

cohort = Cohort.create(name: 'Red Admirals 2013')
cohort = Cohort.create(name: 'Fence Lizards 2013')

cohorts.each_with_index do |cohort_num, index|
	a.get("http://socrates.devbootcamp.com/cohorts/#{cohort_num}") do |cohort_page|
		cohort_page.images.each do |image|
			Student.create(name: image.alt, picture_url: image.src, cohort_id: index+1)
		end
	end
end


week1_groups = [[7,10,1,6], [9,16,17,4], [18,12,19,3], [5,14,8,13], [15,11,2]]
week2_groups = [[4,17,2,6], [11,8,16,14], [5,10,7,15], [18,3,9,19], [13,12,1]]

week1_groups.each_with_index do |group, index|
	new_group = Group.create(name: "Red Admirals 2013 Week 1 Group #{index+1}")
	group.each do |g|
		new_group.students << Student.find(g)
	end
end

week2_groups.each_with_index do |group, index|
	new_group = Group.create(name: "Red Admirals 2013 Week 2 Group #{index+1}")
	group.each do |g|
		new_group.students << Student.find(g)
	end
end


# 1 Avanish Giri
# 2 Brian Pope
# 3 Bryce Archer
# 4 Eadon Jacobs
# 5 Joshua Miramant
# 6 Katharine VanderDrift
# 7 Lillie Chilen
# 8 Lloyd Taylor
# 9 Maria Pacana
# 10 Matt Barackman
# 11 Neil Shah
# 12 Nicholas Kirchner
# 13 Paulette Luftig
# 14 Phillip Mispagel
# 15 Renata Santillan
# 16 Shiv Kumar
# 17 Tej Singh
# 18 Uzma Rahman
# 19 William Bendix

# 3.times do |i|
# 	Group.create_groups_for_week(1, i+1)
# end

# 3.times do |i|
# 	p Group.display_students(1, i+1)
# end