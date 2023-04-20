class ContactsToXls < ApplicationService
    require 'spreadsheet'    
    attr_reader :contacts

    def initialize(contacts)
        @contacts = contacts
    end

    def call
        headers = %w{ Id Date_création Nom Prénom Fonction Maison Organisation Ville Département Région Tag1 Tag2 Tag3 Tag4 Tag5 Téléphone Email Abonné Nbr_Actions Date_MAJ }
    
        Spreadsheet.client_encoding = 'UTF-8'
    
        book = Spreadsheet::Workbook.new
        sheet = book.create_worksheet name: 'Contacts'
        bold = Spreadsheet::Format.new :weight => :bold, :size => 11
    
        sheet.row(0).concat headers
        sheet.row(0).default_format = bold
    
        index = 1
        @contacts.each do | contact |
          fields_to_export = [
            contact.id, 
            contact.created_at, 
            contact.nom,
            contact.prénom,
            contact.fonction,
            contact.try(:maison).try(:nom),
            contact.organisation,
            contact.ville,
            contact.dep_name,
            contact.region_name,
            contact.tag_list[0],
            contact.tag_list[1],
            contact.tag_list[2],
            contact.tag_list[3],
            contact.tag_list[4],
            contact.téléphone,
            contact.email,
            (contact.abonne ? 'Oui' : 'Non'),
            contact.actions.count,
            contact.updated_at
          ]
          sheet.row(index).replace fields_to_export
          index += 1
        end
        return book
    
    end

end