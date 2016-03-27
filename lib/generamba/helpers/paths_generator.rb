module Generamba

  class PathsGenerator

    def self.generate_file_path(prefix, name, template_name, dir_path)
			# The target file's name consists of three parameters: project prefix, module name and template file name.
			# E.g. RDS + Authorization + Presenter.h = RDSAuthorizationPresenter.h
			file_basename = name + File.basename(template_name)
			file_name = prefix ? prefix + file_basename : file_basename

			file_group = File.dirname(template_name)
			file_path = dir_path.join(file_group)
								.join(file_name)
		end

		def self.generate_group_path(template_name, dir_path, group_path)
			file_group = File.dirname(template_name)
			return group_path.join(file_group)
		end

  end

end
