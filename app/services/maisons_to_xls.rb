class MaisonsToXls < ApplicationService
    require 'spreadsheet'    
    attr_reader :maisons

    def initialize(maisons)
        @maisons = maisons
    end
        
    def call
        headers = %w{ Id 
                Date_création  
                Nom
                Adresse
                CP
                Ville
                Dép
                Région
                Téléphone
                Email
                Site
                Latitude
                Longitude
                Mémo
                Nbr_Contacts
                Nbr_Actions 
                Date_MAJ 
            }

        Spreadsheet.client_encoding = 'UTF-8'

        book = Spreadsheet::Workbook.new
        sheet = book.create_worksheet name: 'Maisons'
        bold = Spreadsheet::Format.new :weight => :bold, :size => 11

        sheet.row(0).concat headers
        sheet.row(0).default_format = bold

        index = 1
        @maisons.each do | maison |
            fields_to_export = [
                maison.id, 
                maison.created_at, 
                maison.nom,
                maison.adresse,
                maison.cp,
                maison.ville,
                maison.dep_name,
                maison.region_name,
                maison.téléphone,
                maison.email,
                maison.site,
                maison.latitude,
                maison.longitude,
                maison.description,
                maison.contacts.count,
                maison.actions.count,
                maison.updated_at
            ]
            sheet.row(index).replace fields_to_export
            index += 1
        end
        return book

    end
end