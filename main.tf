resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "$schema" = "http://json-schema.org/draft-04/schema#",
        "properties" = {
            "searchAttribute" = {
                "description" = "Enter specific string to search for E.g. 'Postcode 2060'",
                "title" = "Search Attribute",
                "type" = "string"
            }
        },
        "required" = [
            "searchAttribute"
        ],
        "type" = "object"
    })
    contract_output = jsonencode({
        "$schema" = "http://json-schema.org/draft-04/schema#",
        "properties" = {
            "contactAddress1" = {
                "description" = "",
                "title" = "Address Line 1",
                "type" = "string"
            },
            "contactCellPhone" = {
                "description" = "",
                "title" = "Cell Phone",
                "type" = "string"
            },
            "contactCity" = {
                "description" = "",
                "title" = "City",
                "type" = "string"
            },
            "contactCountryCode" = {
                "description" = "",
                "title" = "Country Code",
                "type" = "string"
            },
            "contactFirstName" = {
                "description" = "",
                "title" = "First Name",
                "type" = "string"
            },
            "contactHomePhone" = {
                "description" = "",
                "title" = "Home Phone",
                "type" = "string"
            },
            "contactId" = {
                "description" = "",
                "title" = "Id",
                "type" = "string"
            },
            "contactLastName" = {
                "description" = "",
                "title" = "Last Name",
                "type" = "string"
            },
            "contactOrgName" = {
                "description" = "",
                "title" = "Organization",
                "type" = "string"
            },
            "contactOrgType" = {
                "description" = "",
                "title" = "Organization Type",
                "type" = "string"
            },
            "contactOtherEmail" = {
                "description" = "",
                "title" = "Other Email",
                "type" = "string"
            },
            "contactPersonalEmail" = {
                "description" = "",
                "title" = "Personal Email",
                "type" = "string"
            },
            "contactPostalCode" = {
                "description" = "",
                "title" = "Postal Code",
                "type" = "string"
            },
            "contactState" = {
                "description" = "",
                "title" = "State",
                "type" = "string"
            },
            "contactTitle" = {
                "description" = "",
                "title" = "Title",
                "type" = "string"
            },
            "contactWorkEmail" = {
                "description" = "",
                "title" = "Work Email",
                "type" = "string"
            },
            "contactWorkPhone" = {
                "description" = "",
                "title" = "Work Phone",
                "type" = "string"
            }
        },
        "type" = "object"
    })
    
    config_request {
        request_template     = "$${input.rawRequest}"
        request_type         = "GET"
        request_url_template = "/api/v2/externalcontacts/contacts?q=$esc.url($${input.searchAttribute})&expand=externalOrganization"
        headers = {
			Content-Type = "application/json"
		}
    }

    config_response {
        success_template = "{\"contactId\": $${successTemplateUtils.firstFromArray($${contactId})}, \"contactFirstName\": $${successTemplateUtils.firstFromArray($${contactFirstName})}, \"contactLastName\": $${successTemplateUtils.firstFromArray($${contactLastName})}, \"contactTitle\": $${successTemplateUtils.firstFromArray(\"$${contactTitle}\",\"$esc.quote$esc.quote\")}, \"contactPostCode\": $${successTemplateUtils.firstFromArray(\"$${contactPostCode}\",\"$esc.quote$esc.quote\")}, \"contactOrgName\": $${successTemplateUtils.firstFromArray(\"$${contactOrgName}\",\"$esc.quote$esc.quote\")}, \"contactOrgType\": $${successTemplateUtils.firstFromArray(\"$${contactOrgType}\",\"$esc.quote$esc.quote\")}, \"contactWorkPhone\": $${successTemplateUtils.firstFromArray(\"$${contactWorkPhone}\",\"$esc.quote$esc.quote\")}, \"contactCellPhone\": $${successTemplateUtils.firstFromArray(\"$${contactCellPhone}\",\"$esc.quote$esc.quote\")}, \"contactHomePhone\": $${successTemplateUtils.firstFromArray(\"$${contactHomePhone}\",\"$esc.quote$esc.quote\")}, \"contactAddress1\": $${successTemplateUtils.firstFromArray(\"$${contactAddress1}\",\"$esc.quote$esc.quote\")}, \"contactCity\": $${successTemplateUtils.firstFromArray(\"$${contactCity}\",\"$esc.quote$esc.quote\")}, \"contactState\": $${successTemplateUtils.firstFromArray(\"$${contactState}\",\"$esc.quote$esc.quote\")}, \"contactCountryCode\": $${successTemplateUtils.firstFromArray(\"$${contactCountryCode}\",\"$esc.quote$esc.quote\")}}"
        translation_map = { 
			contactCity = "$.entities[?(@.id != '')].address.city"
			contactId = "$.entities[?(@.id != '')].id"
			contactWorkPhone = "$.entities[?(@.id != '')].workPhone.e164"
			contactFirstName = "$.entities[?(@.id != '')].firstName"
			contactAddress1 = "$.entities[?(@.id != '')].address.address1"
			contactOrgName = "$.entities[?(@.id != '')].externalOrganization.name"
			contactCellPhone = "$.entities[?(@.id != '')].cellPhone.e164"
			contactTitle = "$.entities[?(@.id != '')].title"
			contactState = "$.entities[?(@.id != '')].address.state"
			contactHomePhone = "$.entities[?(@.id != '')].homePhone.e164"
			contactOrgType = "$.entities[?(@.id != '')].externalorganization.companyType"
			contactLastName = "$.entities[?(@.id != '')].lastName"
			contactCountryCode = "$.entities[?(@.id != '')].address.countryCode"
			contactPostCode = "$.entities[?(@.id != '')].address.postalCode"
		}
               
    }
}