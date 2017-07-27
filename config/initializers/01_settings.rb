require Rails.root.join('lib/constantine')
ConcrnConfig = Constantine.load(Rails.root.join('config/settings.yml'), env: Rails.env)
