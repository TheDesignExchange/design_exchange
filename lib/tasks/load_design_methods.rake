namespace :methods do
  desc "Load all methods into the database"
  task :load => :environment do
    filename = File.join(Rails.root, 'lib/tasks/data/design_methods.xls')
    fields = Hash.new

    DesignMethod.destroy_all

    data = Spreadsheet.open(filename).worksheet 0

    keys = {
      analy: "Analyzing and Synthesizing Information",
      build: "Building Prototypes and Mock-ups",
      commu: "Communicating Within and Across Teams",
      evalu: "Evaluating and Choosing",
      gathe: "Gathering Information",
      gener: "Generating Ideas and Concepts",
    }
    categories = Hash.new

    data.each do |row|
      fields[:name]      = row[1].to_s.strip
      fields[:overview]  = row[2].to_s.strip
      fields[:process]   = row[3].to_s.strip
      fields[:principle] = row[4].to_s.strip
      # FILL: load citations from spreadsheet

      design_method = DesignMethod.new(fields)

      if !design_method.save
        p "Error while creating a design method"
      else
        p design_method
      end

      # Read in categories

      string = row[6]

      if string and !string.include?('http') and !string.include?('pg')
        row[5].downcase.split(/[\n,]/).each do |cat|  # split by new line character
          if !cat.blank?
            cat = cat.strip
            keys.each do |key, title|
              if cat.include?(key.to_s)
                design_method.method_categories << MethodCategory.where(name: title).first_or_create!
                p "#{design_method.name}: #{design_method.method_categories.map {|c| c.name}}"
              end
            end
          end
        end
      end

      # citation = row[4]
      # # not working: somehow the thing being updated in DB is method citations
      # # and not citations.
      # if citation #hard to determine what to filter or not.
      #   citation.split(/[\n\*]/).each do |cit|
      #     if !cit.blank?
      #       design_method.citations << Citation.where(text: cit).first_or_create!
      #       p "#{design_method.name}: #{design_method.citations.map {|c| c.text}}"
      #     end
      #   end
      # end
    end
  end

  namespace :categories do

    desc "Scan for categories"
    task :scan => :environment do
      filename = File.join(Rails.root, 'lib/tasks/data/design_methods.xls')

      data = Spreadsheet.open(filename).worksheet 0

      categories = Hash.new

      data.each do |row|
        string = row[5]

        if string and !string.include?('http') and !string.include?('pg')
          row[5].downcase.split(/[\n,]/).each do |cat|
            if !cat.blank?
              cat = cat.strip
              categories[cat] = categories[cat] ? categories[cat]+1 : 1
            end
          end
        end
      end

      categories.map {|name, count| name}.sort.each {|name| p name}
    end

    desc "Normalize categories and count"
    task normalize: :environment do
      keys = [
        "analy",
        "build",
        "commu",
        "evalu",
        "gathe",
        "gener",
      ]

      filename = File.join(Rails.root, 'lib/tasks/data/design_methods.xls')

      data = Spreadsheet.open(filename).worksheet 0

      categories = Hash.new

      data.each do |row|
        string = row[5]

        if string and !string.include?('http') and !string.include?('pg')
          row[5].downcase.split(/[\n,]/).each do |cat|
            if !cat.blank?
              cat = cat.strip
              keys.each do |key|
                if cat.include?(key)
                  categories[key] = categories[key] ? categories[key]+1 : 1
                end
              end
            end
          end
        end
      end

      p categories

    end

  end

end
