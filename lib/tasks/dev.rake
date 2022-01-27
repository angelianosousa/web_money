namespace :dev do
  desc "TODO"
  task setup: :environment do
    spinner_show("Apagando banco de dados...") { %x( rails db:drop )}
    spinner_show("Criando novo banco de dados...") { %x( rails db:create )}
    spinner_show("Construindo tabelas do banco...") { %x( rails db:migrate )}
    spinner_show("Construindo tabelas do banco...") { %x( rails dev:add_default_user )}
  end

  task add_default_user: :environment do
    User.create(email:"user@user.com", password:"user123", password_confirmation:"user123")
  end

  private

  def spinner_show(msg_start, msg_end = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")   
    spinner.auto_spin 
    spinner.success(msg_end)
  end

end
