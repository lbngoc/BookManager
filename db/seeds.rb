# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sample_authors = [
	"Bonaparte",
	"Sanji",
	"NgocLB",
	"Ruth Rendell",
	"Muriel Spark",
	"Ronoroa Zoro",
	"Mokey D.Luffy"
]

sample_categories = [
	"Fashion",
	"Tech",
	"Comedy",
	"Classic",
	"Sex",
	"Sports",
	"Romance"
]

sample_titles = [
	"The Grass is Always Greener",
	"Murder!",
	"An Occurrence at Owl Creek Bridge One of the Missing",
	"A Boy at Seven\n Fear and Loathing in Aspen",
	"The Higgler",
	"The Open Boat",
	"The Great Switcheroo ",
	"The Speckled Band ",
	"The Five Orange Pips ",
	"Cormack's Black\nMonday/Gerald's Day Off/Fat Boy\nBilly Rules the Middle Lane",
	"The Diamond as Big as the Ritz",
	"From a View to a Kill",
	"The Hostage",
	"A Chance for Mr Lever",
	"A Mere Interlude",
	"The Dancing Partner: Clocks",
	"The Rocking-Horse Winner ",
	"Bliss Feuille d'Album ",
	"Death on the Air",
	"Christmas in Africa",
	"The Ransom of Red Chief; Gift of the Magi",
	"The Pit and the Pendulum",
	"The Vampyre",
	"Irish Revel",
	"Thornapple",
	"Sredni Vashtar, The Secret Sin Septimus Brope,The Lumber Room"
]

sample_categories.each do |category|
	model = Category.new(
		name: category
	)
	model.save
end

sample_authors.each do |author|
	model = Author.new(
		name: author,
		email: author.gsub(/\W/, '').downcase + "@localhost.com"
	)
	model.save
end

sample_titles.each do |title|
	book = Book.create(
		title: title, 
		year: 1991 + rand(sample_titles.size)		
	)
	book.author = Author.first(:order => "RAND()")
	book.category = Category.first(:order => "RAND()")
	book.save
end

# create sample users
admin_user = User.new(
		email: "admin@localhost.com",
		password: "admin123"
	)
admin_user.save
demo_user = User.new(
		email: "demo@localhost.com",
		password: "demo123"
	)
demo_user.save
