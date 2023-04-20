class CotisationsToXls < ApplicationService
    require 'spreadsheet'    
    attr_reader :cotisations

    def initialize(cotisations)
        @cotisations = cotisations
    end
        
    def call 
        headers = %w{ Id Date_création Maison Type Ville Période Montant Echéance Etat Mémo Date_MAJ Contacts }

        Spreadsheet.client_encoding = 'UTF-8'

        book = Spreadsheet::Workbook.new
        sheet = book.create_worksheet name: 'Cotisations'
        bold = Spreadsheet::Format.new :weight => :bold, :size => 11

        sheet.row(0).concat headers
        sheet.row(0).default_format = bold

        index = 1
        @cotisations.each do | cotisation |
            fields_to_export = [
                cotisation.id, 
                cotisation.created_at, 
                Maison.unscoped.find(cotisation.adhesion.maison_id).nom,
                Maison.unscoped.find(cotisation.adhesion.maison_id).type_structure,
                Maison.unscoped.find(cotisation.adhesion.maison_id).ville,
                cotisation.période,
                cotisation.montant,
                cotisation.date_échéance,
                cotisation.workflow_state.humanize,
                cotisation.mémo,
                cotisation.updated_at
            ]
            Maison.unscoped.find(cotisation.adhesion.maison_id).contacts.each do |contact|
                fields_to_export << contact.email
            end
            sheet.row(index).replace fields_to_export
            index += 1
        end
        return book
    end
end