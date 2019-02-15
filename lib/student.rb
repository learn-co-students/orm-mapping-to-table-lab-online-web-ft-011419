class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      );
      SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    drop = <<-SQL
      DROP TABLE students
    SQL

    DB[:conn].execute(drop)
  end

  def save
    save = <<-SQL
      INSERT INTO students (name, grade) VALUES (?,?)
      SQL

    DB[:conn].execute(save, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students").flatten[0]
  end

  def self.create(name:, grade: )
    new_student = self.new(name, grade)
    new_student.save
    new_student
  end

end
