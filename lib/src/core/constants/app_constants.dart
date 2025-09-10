import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:easy_localization/easy_localization.dart';

const kAustralia = 'australia';
const kNewZealand = 'new zealand';

class AppConstants {
  static const monthYearFormat = 'MM/yyyy';
  static const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const phoneRegex = r'^\+(64|61)\d{8,9}$';
  static const codeRegex = '^[0-9]+\$';
  static const userNameRegex = '^[A-Za-z0-9]+\$';
}

/// FILTER & SORT
extension KFilterBrandCategory on AppConstants {
  static const women = 'women';
  static const men = 'men';
  static const beauty = 'beauty-wellness';
  static const home = 'home';
  static const kids = 'kids';
}

List<FilterClass> listTypeFilterAndSort = [
  FilterClass(id: 'CATEGORY', name: 'filter_sort.category'.tr()),
  FilterClass(id: 'BRAND', name: 'filter_sort.brand'.tr()),
  FilterClass(id: 'SIZE', name: 'filter_sort.size'.tr()),
  FilterClass(id: 'COLOUR', name: 'filter_sort.colour'.tr()),
  FilterClass(id: 'PRICE', name: 'filter_sort.price'.tr()),
  FilterClass(id: 'DISCOUNT', name: 'filter_sort.discount'.tr()),
  FilterClass(id: 'CONDITION', name: 'filter_sort.condition'.tr()),
  FilterClass(id: 'ITEMLOCATION', name: 'filter_sort.item_location'.tr()),
];

List<FilterClass> dataSortBy = const [
  FilterClass(id: 'relevance', name: 'Relevance'),
  FilterClass(id: 'created', name: 'Latest Listings'),
  FilterClass(id: 'popular', name: 'Most Popular'),
  FilterClass(id: 'priceAsc', name: 'Price: low to high'),
  FilterClass(id: 'priceDesc', name: 'Price: high to low'),
];

List<FilterClass> dataDiscount = const [
  FilterClass(id: 'All', name: 'All'),
  FilterClass(id: '30', name: '30% and more'),
  FilterClass(id: '50', name: '50% and more'),
  FilterClass(id: '75', name: '75% and more'),
  FilterClass(id: '90', name: '90% and more'),
];
List<FilterClass> dataItemLocation = const [
  FilterClass(id: 'nz', name: 'New Zealand Only'),
  FilterClass(id: 'au', name: 'Australia Only'),
];
const Map<String, String> colourLabels = {
  'various': 'Various',
  '#5B5B5B': 'Black',
  '#925C34': 'Brown',
  '#B4349D': 'Purple',
  '#00AF5E': 'Green',
  '#A09B6B': 'Khaki',
  '#0097D1': 'Blue',
  '#B3E6ED': 'Turquoise',
  '#FD5734': 'Red',
  '#FF2F9A': 'Pink',
  '#FFB734': 'Orange',
  '#FFE036': 'Gold',
  '#FFF53A': 'Yellow',
  '#A7A7A7': 'Grey',
  '#FCE5D1': 'Beige',
  '#ECEEEF': 'Silver',
  '#FFFFFF': 'White',
};

class SizeGuideConstants {
  static const sizeGuideStandard = {
    'title': 'Standard',
    'columns': ['AU / NZ', 'Universal', 'US', 'Europe'],
    'rows': [
      ['4', 'XXS', '0', '32'],
      ['6', 'XS', '2', '34'],
      ['8', 'S', '4', '36'],
      ['10', 'M', '6', '38'],
      ['12', 'L', '8', '40'],
      ['14', 'XL', '10', '42'],
      ['16', 'XXL', '12', '44']
    ]
  };

  static const sizeGuideBrands = {
    'title': 'Popular Brands Comparison',
    'columns': ['AU / NZ', 'sass & bide', 'Zimmermann', 'Miss Crabb'],
    'rows': [
      ['4', '-', '-', '-'],
      ['6', '36', '0P', '0'],
      ['8', '38', '0', '1'],
      ['10', '40', '1', '2'],
      ['12', '42', '2', '3'],
      ['14', '44', '3', '4'],
      ['16', '-', '-', '-']
    ]
  };

  static const sizeGuideJeans = {
    'columns': ['AU / NZ', 'International', 'Universal'],
    'rows': [
      ['6', '24', 'XS'],
      ['7', '25', 'XS'],
      ['8', '26', 'S'],
      ['9', '27', 'S'],
      ['10', '28', 'M'],
      ['11', '29', 'M'],
      ['12', '30', 'L'],
      ['13', '31', 'L'],
      ['14', '32', 'XL']
    ]
  };
  static const sizeGuideBras = {
    'title': 'Underbust',
    'columns': ['AU / NZ', '(cm)', 'EU', 'FRA', 'ITA', 'UK/US'],
    'rows': [
      ['8', '65-67', '65', '80', '0', '30'],
      ['10', '67-72', '70', '85', '1', '32'],
      ['12', '72-77', '75', '90', '2', '34'],
      ['14', '77-82', '80', '95', '3', '36'],
      ['16', '82-87', '85', '100', '4', '38'],
      ['18', '87-92', '90', '105', '5', '40'],
      ['20', '92-97', '95', '110', '6', '42'],
      ['22', '97-102', '100', '115', '7', '44']
    ]
  };
  static const sizeGuideBrasOverbust = {
    'title': 'Overbust',
    'columns': [
      '(cm)',
      'A',
      'B',
      'C',
      'D',
      'DD',
      'E',
      'F',
      'G',
      'GG',
      'H',
      'HH',
      'J'
    ],
    'rows': [
      '65-67 77-79 79-81 81-83 83-85 85-87 87-89 89-91 91-93 93-95 95-97 97-99 99-101',
      '67-72 82-84 84-86 86-88 88-90 90-92 92-94 94-96 96-98 98-100 100-102 102-104 104-106',
      '72-77 87-89 89-91 91-93 93-95 95-97 97-99 99-101 101-103 103-105 105-107 107-109 109-111',
      '77-82 92-94 94-96 96-98 98-100 100-102 102-104 104-106 106-108 108-110 110-102 102-104 104-106',
      '82-87 97-99 99-101 101-103 103-105 105-107 107-109 109-111 111-113 113-115 115-117 117-119 119-121',
      '87-92 102-104 104-106 106-108 108-110 110-112 112-114 114-116 116-118 118-120 120-122 122-124 124-126',
      '92-97 107-109 109-111 111-113 113-115 115-117 117-119 119-121 121-123 123-125 125-127 127-129 129-131',
      '97-102 112-114 114-116 116-118 118-120 120-122 122-124 124-126 126-128 128-130 130-132 132-134 134-136'
    ]
  };
  static const sizeGuideFootwear = {
    'columns': ['AU/US', 'EU', 'UK', 'CM'],
    'rows': [
      '4 35 2 20.8',
      '4.5 35.5 2.5 21.3',
      '5 36 3 21.6',
      '5.5 36.5 3.5 22.2',
      '6 37 4 22.5',
      '6.5 37.5 4.5 23',
      '7 38 5 23.5',
      '7.5 38.5 5.5 23.8',
      '8 39 6 24.1',
      '8.5 39.5 6.5 24.6',
      '9 40 7 25.1',
      '9.5 40.5 7.5 25.4',
      '10 41 8 25.9',
      '10.5 41.5 8.5 26.2',
      '11 42 9 26.7',
      '11.5 42.5 9.5 27.1',
      '12 43 10 27.6'
    ]
  };
  static const sizeGuideHats = {
    'columns': ['Generic', 'Head Circumference (CM)'],
    'rows': [
      ['S/M', '57'],
      ['M/L', '59'],
      ['L/XL', '58']
    ]
  };
  static const sizeGuideRings = {
    'columns': [
      'Universal',
      'AU/UK US',
      'Inside Diameter',
      'Inside Circumference'
    ],
    'rows': [
      ['XXS', 'H', '1/2', '4', '14.86', '46.68'],
      ['XS', 'J', '1/2', '5', '15.7', '49.32'],
      ['S', 'M', '6', '16.51', '51.87'],
      ['M', 'O', '7', '17.35', '54.51'],
      ['L', 'Q', '8', '18.19', '57.15']
    ]
  };
  static const sizeGuideKids = {
    'columns': ['Size', 'Age', 'Height (CM)', 'Weight (CM)', 'Chest (CM)'],
    'rows': [
      ['0', 'Newborn', '52', '3.5', ''],
      ['0', '0-3 Months', '62', '6', ''],
      ['0', '3-6 Months', '68', '8', ''],
      ['0', '6-12 Months', '76', '10', ''],
      ['1', '12-18 Months', '84', '12', ''],
      ['2', '18-24 Months', '92', '13.5', ''],
      ['1', '1', '84', '52', '53'],
      ['2', '2', '92', '54', '56'],
      ['3', '3', '100', '55', '58'],
      ['4', '4', '108', '56', '60'],
      ['5', '5', '115', '57', '62'],
      ['6', '6', '120', '58', '64'],
      ['7', '7', '125', '59', '66'],
      ['8', '8', '130', '60', '68']
    ]
  };
  static const sizeGuideKidsFootwear = {
    'columns': ['MM (Foot Length)', 'EU', 'UK', 'US', 'Age', 'Univ.'],
    'rows': [
      ['84-90', '15', '0', '0.5', '0-3 mnths', 'NB'],
      ['91-98', '16', '0.5', '1', '3-9 mnths', 'S'],
      ['99-104', '17', '1', '1.5', '3-9 mnths', 'S'],
      ['105-111', '18', '2', '3', '9-15 mnths', 'M'],
      ['112-118', '19', '3', '4', '9-15 mnths', 'M'],
      ['119-125', '20', '3.5', '4.5', '15-27 mnths', 'L'],
      ['126-132', '21', '4.5', '5.5', '15-27 mnths', 'L'],
      ['133-139', '22', '5', '6', '2 yrs', 'XL'],
      ['140-145', '23', '6', '7', '2 yrs', 'XL'],
      ['146-152', '24', '7', '8', '2-3 yrs', '2XL'],
      ['153-159', '25', '7.5', '8.5', '2-3 yrs', '2XL'],
      ['160-166', '26', '8.5', '9.5', '3-4 yrs', '3XL'],
      ['167-172', '27', '9', '10', '3-4 yrs', '3XL'],
      ['173-179', '28', '10', '11', '4-5 yrs', '4XL'],
      ['180-185', '29', '11', '12', '4-5 yrs', '4XL'],
      ['186-192', '30', '11.5', '12.5', '5-6 yrs', '5XL'],
      ['193-199', '31', '12', '13', '5-6 yrs', '5XL'],
      ['200-206', '32', '13', '1', '6-7 yrs', '6XL'],
      ['207-213', '33', '1', '1.5', '7-8 yrs', '6XL']
    ]
  };
}
