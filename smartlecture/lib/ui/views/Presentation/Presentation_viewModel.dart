import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/lecture_model/Item.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/models/lecture_model/Section.dart';
import 'package:smartlecture/models/user_model/UserLectures.dart';
import 'package:smartlecture/models/common/SectionIndex..dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/models/lecture_model/Page.dart' as p;

var db = FireStoreUtils.firestore;

class PresentationViewModel with ChangeNotifier {
  Lecture _lecture;
  Lecture example;
  SectionIndex _currentIndex;
  User currentUser;
  String uid;

  UserLecture myLectures;
  get currentIndex => _currentIndex;
  get lecture => _lecture;

  get currentSection => _currentIndex.currentSectionIndex;
  get currentPage => _currentIndex.currentPageIndex;
  get currentItem => _currentIndex.currentItemIndex;
  PresentationViewModel({Lecture init}) {
    _lecture = init;

    _currentIndex = new SectionIndex(
        currentPageIndex: 0, currentSectionIndex: 0, currentItemIndex: 0);
  }
  void increasePageIndex() {
    if (_currentIndex.currentPageIndex <
        _lecture.section[_currentIndex.currentSectionIndex].page.length - 1) {
      _currentIndex.currentPageIndex++;
    } else {
      if (_currentIndex.currentSectionIndex < _lecture.section.length - 1) {
        _currentIndex.currentPageIndex = 0;
        _currentIndex.currentSectionIndex++;
      }
      //_lecture.section[_currentIndex.currentSectionIndex].page.length - 1;
    }
    notifyListeners();
  }

  void decreasePageIndex() {
    if (_currentIndex.currentPageIndex == 0 &&
        _currentIndex.currentSectionIndex == 0) return;
    if (_currentIndex.currentPageIndex > 0) {
      _currentIndex.currentPageIndex--;
    } else {
      if (_currentIndex.currentSectionIndex > 0) {
        _currentIndex.currentSectionIndex--;
        _currentIndex.currentPageIndex =
            _lecture.section[_currentIndex.currentSectionIndex].page.length - 1;
      }
      //_lecture.section[_currentIndex.currentSectionIndex].page.length - 1;
    }
    print("lecture length: ${_lecture.section.length}"
        "page length: ${_lecture.section[_currentIndex.currentSectionIndex].page.length}"
        "section index: ${_currentIndex.currentSectionIndex}"
        "page index: ${_currentIndex.currentPageIndex}");
    notifyListeners();
  }

  void setCurrenindex(SectionIndex index) {
    if (index.currentPageIndex >= 0) {
      if (_currentIndex.currentPageIndex <
          _lecture.section[_currentIndex.currentSectionIndex].page.length) {
        _currentIndex.currentPageIndex = index.currentPageIndex;
      } else {
        _currentIndex.currentPageIndex =
            _lecture.section[_currentIndex.currentSectionIndex].page.length - 1;
      }
    }
    if (index.currentSectionIndex >= 0) {
      if (_currentIndex.currentSectionIndex < _lecture.section.length) {
        _currentIndex.currentSectionIndex = index.currentSectionIndex;
      } else {
        _currentIndex.currentSectionIndex = _lecture.section.length - 1;
      }
    }
    if (index.currentItemIndex >= 0) {
      if (_currentIndex.currentItemIndex <
          _lecture.section[_currentIndex.currentSectionIndex]
              .page[_currentIndex.currentPageIndex].items.item.length) {
        _currentIndex.currentItemIndex = index.currentItemIndex;
      } else {
        _currentIndex.currentItemIndex = _lecture
                .section[_currentIndex.currentSectionIndex]
                .page[_currentIndex.currentPageIndex]
                .items
                .item
                .length -
            1;
      }
    }
    notifyListeners();
  }

  void dispose() {
    print("dispose PresentationViewModel");
    super.dispose();
  }
}
