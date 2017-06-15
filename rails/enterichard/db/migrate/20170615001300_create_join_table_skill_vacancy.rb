class CreateJoinTableSkillVacancy < ActiveRecord::Migration[5.1]
  def change
    create_join_table :skills, :vacancies do |t|
      t.index [:skill_id, :vacancy_id]
      t.index [:vacancy_id, :skill_id]
    end
  end
end
