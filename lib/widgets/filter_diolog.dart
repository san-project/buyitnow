import 'package:buyitnow/providers/product_provider.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/category_provider.dart';

enum RadioValues { lowToHigh, highToLOW, relevance }

Future<bool?> showFilterOptions(BuildContext context) async {
  return await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      builder: (context) {
        final provider = Provider.of<CategoryProvider>(context);
        final isCategory = provider.isCategory;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close))
                ],
              ),
            ),
            Container(
              color: Colors.grey,
              height: 1,
              width: double.infinity,
            ),
            Expanded(
                child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<CategoryProvider>().changeFilter(false);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                            height: 30,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: !isCategory
                                    ? Colors.orange[900]
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                          ),
                          Text(
                            'Sort',
                            style: TextStyle(
                                color: !isCategory
                                    ? Colors.orange[900]
                                    : Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<CategoryProvider>().changeFilter(true);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                            height: 30,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: isCategory
                                    ? Colors.orange[900]
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                          ),
                          Text(
                            'Category',
                            style: TextStyle(
                                color: isCategory
                                    ? Colors.orange[900]
                                    : Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  color: Colors.grey,
                  height: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                ),
                isCategory
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: provider.categories.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              activeColor: Colors.orange[700],
                              checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              title: Text(provider.categories[index].category),
                              value: provider.selectedCategories
                                  .contains(provider.categories[index].id),
                              onChanged: (isSelected) {
                                provider.handleCheckBox(
                                    provider.categories[index].id, isSelected);
                              },
                            );
                          },
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Radio<RadioValues>(
                                activeColor: Colors.orange[700],
                                value: RadioValues.relevance,
                                groupValue: provider.radioValues,
                                onChanged: (radio) {
                                  provider.radioOnChange(radio);
                                },
                              ),
                              Text(
                                'Relevance (Default)',
                                style: TextStyle(
                                    color: provider.radioValues ==
                                            RadioValues.relevance
                                        ? Colors.black
                                        : Colors.grey),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Radio<RadioValues>(
                                activeColor: Colors.orange[700],
                                value: RadioValues.highToLOW,
                                groupValue: provider.radioValues,
                                onChanged: (radio) {
                                  provider.radioOnChange(radio);
                                },
                              ),
                              Text(
                                'Cost: High to Low',
                                style: TextStyle(
                                    color: provider.radioValues ==
                                            RadioValues.highToLOW
                                        ? Colors.black
                                        : Colors.grey),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Radio<RadioValues>(
                                activeColor: Colors.orange[700],
                                value: RadioValues.lowToHigh,
                                groupValue: provider.radioValues,
                                onChanged: (radio) {
                                  provider.radioOnChange(radio);
                                },
                              ),
                              Text(
                                'Cost: Low to High',
                                style: TextStyle(
                                    color: provider.radioValues ==
                                            RadioValues.lowToHigh
                                        ? Colors.black
                                        : Colors.grey),
                              )
                            ],
                          )
                        ],
                      )
              ],
            )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(-2, -2),
                    spreadRadius: 5,
                    blurRadius: 5)
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.orange[700]),
                    onPressed: context.read<CategoryProvider>().radioValues ==
                                RadioValues.relevance &&
                            provider.selectedCategories.isEmpty
                        ? null
                        : () {
                            context.read<CategoryProvider>().clearFilters();
                          },
                    child: const Text(
                      'Clear Filters',
                      style: TextStyle(),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[700],
                          foregroundColor: Colors.white),
                      onPressed: context.read<CategoryProvider>().radioValues ==
                                  RadioValues.relevance &&
                              provider.selectedCategories.isEmpty
                          ? null
                          : () {
                              // context
                              //     .read<ProductProvider>()
                              //     .getProductsFromFilter(
                              //         provider.selectedCategories);
                              Navigator.pop(context, true);
                            },
                      child: const Text('Apply Filters'))
                ],
              ),
            )
          ],
        );
      });
}
