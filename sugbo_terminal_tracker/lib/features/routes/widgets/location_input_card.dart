import 'package:flutter/material.dart';

class LocationInputCard extends StatefulWidget {
  final void Function(Map<String, String>?, Map<String, String>?)? onSearch;

  const LocationInputCard({Key? key, this.onSearch}) : super(key: key);

  @override
  State<LocationInputCard> createState() => _LocationInputCardState();
}

class _LocationInputCardState extends State<LocationInputCard> {
  final List<Map<String, String>> _locations = [
    {'title': 'SM City Cebu', 'subtitle': 'North Reclamation Area, Cebu City'},
    {'title': 'IT Park', 'subtitle': 'Lahug, Cebu City'},
    {'title': 'Capitol', 'subtitle': 'Capitol Site / Escario St.'},
    {'title': 'Fuente', 'subtitle': 'Fuente Osmeña Circle'},
    {'title': 'CSBT', 'subtitle': 'Cebu South Bus Terminal / N. Bacalso'},
    {'title': 'SM Seaside', 'subtitle': 'SRP, Cebu City'},
    {'title': 'Il Corso', 'subtitle': 'South Road Properties (SRP)'},
    {'title': 'Anjo World', 'subtitle': 'Minglanilla, Cebu'},
    {'title': 'Airport', 'subtitle': 'Mactan Cebu International Airport'},
    {'title': 'J Mall', 'subtitle': 'Mandaue City'},
    {'title': 'Talisay City', 'subtitle': 'Talisay City Hall / Lawaan'},
    {'title': 'Cebu City (SRP)', 'subtitle': 'South Road Properties'},
  ];

  Map<String, String>? _selectedFrom;
  Map<String, String>? _selectedTo;

  @override
  void initState() {
    super.initState();
    _selectedFrom = null; // Start blank
    _selectedTo = null; // Start blank
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E222D),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildDropdownField('FROM', _selectedFrom, Colors.blue, (value) {
            setState(() {
              if (value != null) _selectedFrom = value;
            });
          }),
          const SizedBox(height: 8),
          const Icon(Icons.swap_vert, color: Colors.blue, size: 20),
          const SizedBox(height: 8),
          _buildDropdownField('TO', _selectedTo, Colors.green, (value) {
            setState(() {
              if (value != null) _selectedTo = value;
            });
          }),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (widget.onSearch != null) {
                  widget.onSearch!(_selectedFrom, _selectedTo);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A2FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Find routes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    Map<String, String>? selectedValue,
    Color dotColor,
    ValueChanged<Map<String, String>?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF2C313D),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.circle, color: dotColor, size: 10),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Map<String, String>>(
                    value: selectedValue,
                    hint: Text(
                      label == 'FROM'
                          ? 'Select Origin...'
                          : 'Select Destination...',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    isExpanded: true,
                    dropdownColor: const Color(0xFF3B404D),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    style: const TextStyle(color: Colors.white),
                    items: _locations.map((location) {
                      return DropdownMenuItem<Map<String, String>>(
                        value: location,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              location['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              location['subtitle']!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
