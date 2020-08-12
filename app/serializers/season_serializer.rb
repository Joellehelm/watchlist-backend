class SeasonSerializer < ActiveModel::Serializer
    attributes :season_number, :show_id

    has_many :episodes


 end
    
