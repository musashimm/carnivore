
BACKUP_DIR='db_backups'
FULL_DIR=RAILS_ROOT+"/db/"+BACKUP_DIR
TIMESTAMP = Time.now.strftime('%Y%m%d_%H%M%S')

config = nil

namespace :db do

	task :create_backup_dir do
		if File.exists?(FULL_DIR)
			puts "#{FULL_DIR} exists"
			puts
		else
			puts "#{cdir} doesn't exist so we're creating"
			puts
			Dir.mkdir FULL_DIR
		end
	end

	task :load_config => [:environment] do
		config = ActiveRecord::Base.configurations[RAILS_ENV]
	end

	desc "Dumps db data to file"
	task :dump_data => [:load_config, :create_backup_dir] do
		FileUtils.cd(FULL_DIR)
		backup_file=config['database']+"_"+TIMESTAMP+".dump"
		puts "Making backup of: #{config['database']} using username: #{config['username']} to #{backup_file}"
		puts
		result=`pg_dump -i -h #{config['host']} --verbose -U #{config['username']} --data-only --format c --column-inserts --file #{backup_file} #{config['database']}`
		puts "\nMaking symbolic link to last dump\n"
		FileUtils.ln_s(backup_file,config['database']+"_last.dump",:force => true)
		puts "\nBackup done\n\n"
	end
#/usr/local/mysql/bin/mysqldump musashim_cms -u musashim_cms --password=carn1vore  --default-character-set=utf8 --verbose --complete-insert --result-file tmp/dump.db --no-create-info

	desc "Lists backups directory"
	task :list_backups => [:load_config, :create_backup_dir] do
		puts `ls -tr #{FULL_DIR}/*.dump`
	end

	desc "Restores last db backup"
	task :restore_last => [:load_config, :create_backup_dir] do
		file_with_backup=FULL_DIR+"/"+config['database']+"_last.dump"
		if File.exist?(file_with_backup) 
			`pg_restore -h #{config['host']} --verbose -U #{config['username']} -d #{config['database']} -F c #{file_with_backup}`
		else
			puts "\nThere is no backup file to restore: #{file_with_backup}\n\n"
		end
	end
end
