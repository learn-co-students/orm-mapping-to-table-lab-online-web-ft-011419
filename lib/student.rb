class Student
  attr_accessor :grade, :name
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def id
    @id
  end

  def initialize(name, grade)
    @grade = grade
    @name = name
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    sql = <<-SQL
      INSERT INTO students (grade, name)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.grade, self.name)
    @id = DB[:conn].execute("SELECT id FROM students WHERE id = (SELECT MAX(id) FROM students);")[0][0]
  end
  def self.create(student_attr)
    student = self.new(student_attr[:name], student_attr[:grade])
    student.save
    student
  end

end
