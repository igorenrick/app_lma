import 'package:app_lma/models/chemical_material.dart';
import 'package:flutter/material.dart';

class CabinetCard extends StatelessWidget {
  final ChemicalMaterial chemicalMaterial;
  const CabinetCard({
    Key? key,
    required this.chemicalMaterial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 18, 12, 18),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 242, 242, 247),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Image.network(
                'https://chem.nlm.nih.gov/chemidplus/structure/${chemicalMaterial.CAS}',
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: Icon(
                        Icons.science_outlined,
                        size: 24,
                        color: Colors.black,
                      ),
                    );
                  }
                },
                errorBuilder: (context, exception, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.science_outlined,
                      size: 24,
                      color: Color.fromARGB(255, 142, 142, 147),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chemicalMaterial.name,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${chemicalMaterial.currentAmount} ${chemicalMaterial.getUnity()}',
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color.fromARGB(255, 142, 142, 147),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    chemicalMaterial.LMAId,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: Color.fromARGB(255, 93, 153, 150),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
