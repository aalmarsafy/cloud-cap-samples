using { sap.capire.bookshop, AdminService } from '@capire/bookshop';

////////////////////////////////////////////////////////////////////////////
//
//	Books Object Page
//

annotate AdminService.Books with @(
	UI: {
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Translations}', Target:  'texts/@UI.LineItem'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}', Target: '@UI.FieldGroup#Details'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Admin}', Target: '@UI.FieldGroup#Admin'},
		],
		FieldGroup#General: {
			Data: [
				{Value: title},
				{Value: author_ID},
				{Value: genre_ID},
				{Value: descr},
			]
		},
		FieldGroup#Details: {
			Data: [
				{Value: stock},
				{Value: price},
				{Value: currency_code, Label: '{i18n>Currency}'},
			]
		},
		FieldGroup#Admin: {
			Data: [
				{Value: createdBy},
				{Value: createdAt},
				{Value: modifiedBy},
				{Value: modifiedAt}
			]
		}
	}
);

// Give hints to tools that these elements exist. See srv/ on how they are populated
// TODO find a better way to have 'default' fields that still can be overwritten.
extend bookshop.Authors with {
	virtual age: Integer;
	virtual lifetime: String;
}
annotate AdminService.Authors with @(
	UI: {
		HeaderInfo: {
			Description: {Value: lifetime}
		},
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}', Target: '@UI.FieldGroup#Details'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Books}', Target: 'books/@UI.LineItem'},
		],
		FieldGroup#Details: {
			Data: [
				{Value: age, Label: '{i18n>Age}'},
				{Value: placeOfBirth},
				{Value: placeOfDeath},
			]
		},
	}
);



////////////////////////////////////////////////////////////
//
//  Draft for Localized Data
//

annotate sap.capire.bookshop.Books with @fiori.draft.enabled;
annotate AdminService.Books with @odata.draft.enabled;

annotate AdminService.Books_texts with @(
	UI: {
		Identification: [{Value:title}],
		SelectionFields: [ locale, title ],
		LineItem: [
			{Value: locale, Label: 'Locale'},
			{Value: title, Label: 'Title'},
			{Value: descr, Label: 'Description'},
		]
	}
);

// Add Value Help for Locales
annotate AdminService.Books_texts {
	locale @ValueList:{entity:'Languages',type:#fixed}
}
// In addition we need to expose Languages through AdminService
using { sap } from '@sap/cds/common';
extend service AdminService {
	entity Languages as projection on sap.common.Languages;
}
