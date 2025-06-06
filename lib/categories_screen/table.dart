import 'package:flutter/material.dart';

final snowShovelingTable = Table(
  border: TableBorder.all(color: Colors.black),
  children: [

    // first Row
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Driveway Size',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Additional\n Charge',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Total Price\n (per hour)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),

    // second Row
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Small\n (1 - 2 Cars)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 0',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 17 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),

    // third Row
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Medium\n (3 - 4 Cars)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '+ \$ 0.50',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 17.50 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),

    // fourth Row
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Large\n (5+ Cars)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '+ \$ 1.00',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 18 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  ],
);

final tutoringTable = Table(
  border: TableBorder.all(color: Colors.black),
  children: [

    // first row
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Subject',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Additional\n Charge',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Total Price\n (per hour)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    // second Row
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Any',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'N / A',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 15',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    )
  ],
);

final babySittingTable = Table(
  border: TableBorder.all(color: Colors.black),
  children: [
    // first Row
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Number of Kids',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Additional\n Charge',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Total Price\n (per hour)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    // second Row
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '1',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 0',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 15 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    // third Row
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '2 - 3',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '+ \$ 0.30',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 15.30 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    // fourth Row
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '4 - 5',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '+ \$ 1.00',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 16 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '6+',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '+ \$ 2.00',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 17 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    )
  ],
);

final petWalkingSitting = Table(
  border: TableBorder.all(color: Colors.black),
  children: [

    // first Row
    TableRow(children: [
      Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Service',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      
      Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Additional\n Charge',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Total Price\n (per hour)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
    ],),

    // second Row
    TableRow(children: [
      Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Walking / Sitting',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

      Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'N / A',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

      Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 15 / hr \n(per pet)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
    ],),

    // third Row
    TableRow(children: [
      Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Feeding / Medication',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

      Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '+ \$ 5.00 flat fee',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

      Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 15 / hr + \$ 5.00 (per pet)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
    ],),

    // fourth Row
    TableRow(children: [
      Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Bath / Brush',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

      Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '+ \$ 10.00 flat fee',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

      Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 15 / hr + \$ 10.00 (per pet)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
    ],),
  ],
);


final groceryShoppingTable = Table(
  border: TableBorder.all(color: Colors.black),
  children: [
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Number of Stores',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Additional\n Charge',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Total Price\n (per hour)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'One Store',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 0',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 18 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    )
  ],
);

final lawnMowingTable = Table(
  border: TableBorder.all(color: Colors.black),
  children: [
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Total Price\n (per hour)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 18 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    )
  ],
);

final carWashingTable = Table(
  border: TableBorder.all(color: Colors.black),
  children: [
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Places',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Total Price\n (per hour)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Interior Only',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 16 / hr (per Car)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Exterior Only',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 16 / hr (per Car)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Interior & Exterior',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 18 / hr (per Car)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    )
  ],
);


final houseCleaningTable = Table(
  border: TableBorder.all(color: Colors.black),
  children: [
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Standardized\n cleaning',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Total Price\n (per hour)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 120,
          alignment: Alignment.center,
          child: Text(
            'Dusting\nVaccuming/Sweeping\nMopping\nCleaning Counter Tops\nTrash Removal',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 120,
          alignment: Alignment.center,
          child: Text(
            '\$ 18 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    )
  ],
);

final furnitureAssemblyTable = Table(
  border: TableBorder.all(color: Colors.black),
  children: [
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Item Size',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Additional\n Charge',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Total Price\n (per hour)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            'Small Items (Chairs, Nightstands, Shelves, etc.)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            'N / A',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '\$ 16 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            'Medium Items (Desks, Dressers, Tv Stands, etc.)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '+ \$ 0. 25',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '\$ 16.30 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            'Large Items (Beds, Wardrobes, etc.)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '+ \$ 0.90',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '\$ 16.90 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    )
  ],
);

final paintingTable = Table(
  border: TableBorder.all(color: Colors.black),
  children: [
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Subject',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Additional\n Charge',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Price\n (per hour)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Any',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'N / A',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            '\$ 18',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    )
  ],
);

final packingMovingTable = Table(
  border: TableBorder.all(color: Colors.black),
  children: [
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Job Type',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Manpower Needed',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Price\n (per hour)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            'Light Items (Boxes, Small Furniture)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '1 Person',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '\$ 20 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            'Moderate Items (Chairs, Desks, Sofas)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '2 People',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '\$ 30 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            'Heavy Items (Wardrobes, Large Tables)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '3 People',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '\$ 60 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            'Extra Heavy Items (Pianos, Large Appliances)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '4 People',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 90,
          alignment: Alignment.center,
          child: Text(
            '\$ 80 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    )
  ],
);

final holidayHelpTable = Table(
  border: TableBorder.all(color: Colors.black),
  children: [
    TableRow(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Service',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(133, 33, 149, 243),
          ),
          child: Text(
            'Rate',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    ),

    TableRow(
      children: [
        Container(
          height: 120,
          alignment: Alignment.center,
          child: Text(
            'Gift Wrapping\nDecorating\nTree Setup\nShopping Assistance\nEvent Setup & Cleanup',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 120,
          alignment: Alignment.center,
          child: Text(
            '\$ 15 / hr',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]
    )
  ],
);


