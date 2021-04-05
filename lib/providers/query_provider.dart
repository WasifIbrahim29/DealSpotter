import 'package:deal_spotter/models/categories_model.dart';
import 'package:deal_spotter/models/deals_model.dart';
import 'package:deal_spotter/models/discussion_model.dart';
import 'package:deal_spotter/models/history_model.dart';
import 'package:deal_spotter/models/notification_model.dart';
import 'package:deal_spotter/models/saved_model.dart';
import 'package:deal_spotter/models/stores_model.dart';
import 'package:deal_spotter/models/voucher_codes_model.dart';
import 'package:flutter/material.dart';

class QueryProvider extends ChangeNotifier {
  String query;
  List<VoucherCodesModel> myVouchers = [];
  List<VoucherCodesModel> myFilteredVouchers = [];

  List<DealsModel> myLatestDeals = [];
  List<DealsModel> myFilteredLatestDeals = [];

  List<DealsModel> myForums = [];
  List<DealsModel> myFilteredForums = [];

  List<StoresModel> myStores = [];
  List<StoresModel> myFilteredStores = [];

  List<CategoriesModel> myCategories = [];
  List<CategoriesModel> myFilteredCategories = [];

  List<DealsModel> myMainForums = [];
  List<DealsModel> myFilteredMainForums = [];

  List<NotificationModel> myNotifications = [];
  List<NotificationModel> myFilteredNotifications = [];

  List<SavedModel> mySaved = [];
  List<SavedModel> myFilteredSaved = [];

  List<HistoryModel> myHistory = [];
  List<HistoryModel> myFilteredHistory = [];

  List<DiscussionModel> myNewDiscussion = [];
  List<DiscussionModel> myFilteredNewDiscussion = [];

  List<DiscussionModel> myOldDiscussion = [];
  List<DiscussionModel> myFilteredOldDiscussion = [];

  void addVoucher(List<VoucherCodesModel> vouchers) {
    print("wtf");
    for (var voucher in vouchers) {
      this.myVouchers.add(voucher);
      this.myFilteredVouchers.add(voucher);
    }
    print("Kill me");
    notifyListeners();
  }

  void changeVouchers(query) {
    print("q: $query");

    this.myFilteredVouchers.clear();
    myVouchers.forEach(
      (element) {
        print(element);
        if (element.voucher_title.toLowerCase().contains(query.toLowerCase())) {
          this.myFilteredVouchers.add(element);
        }
      },
    );

    notifyListeners();
  }

  void addLatestDeal(List<DealsModel> latestDeals) {
    print("wtf");
    for (var latestDeal in latestDeals) {
      this.myLatestDeals.add(latestDeal);
      this.myFilteredLatestDeals.add(latestDeal);
    }
    print("Kill me");
    notifyListeners();
  }

  void changeLatestDeal(query) {
    print("q: $query");

    this.myFilteredLatestDeals.clear();
    myLatestDeals.forEach(
      (element) {
        print(element);
        if (element.deal_title.toLowerCase().contains(query.toLowerCase())) {
          this.myFilteredLatestDeals.add(element);
        }
      },
    );

    notifyListeners();
  }

  void addForum(List<DealsModel> forums) {
    print("wtf");
    for (var latestDeal in forums) {
      this.myForums.add(latestDeal);
      this.myFilteredForums.add(latestDeal);
    }
    print("Kill me");
    notifyListeners();
  }

  void changeForum(query) {
    print("q: $query");

    this.myFilteredForums.clear();
    myForums.forEach(
      (element) {
        print(element);
        if (element.deal_title.toLowerCase().contains(query.toLowerCase())) {
          this.myFilteredForums.add(element);
        }
      },
    );

    notifyListeners();
  }

  void addStore(List<StoresModel> forums) {
    print("wtf");
    for (var latestDeal in forums) {
      this.myStores.add(latestDeal);
      this.myFilteredStores.add(latestDeal);
    }
    print("Kill me");
    notifyListeners();
  }

  void changeStore(query) {
    print("q: $query");

    this.myFilteredStores.clear();
    myStores.forEach(
      (element) {
        print(element);
        if (element.name.toLowerCase().contains(query.toLowerCase())) {
          this.myFilteredStores.add(element);
        }
      },
    );

    notifyListeners();
  }

  void addCategory(List<CategoriesModel> forums) {
    print("wtf");
    for (var latestDeal in forums) {
      this.myCategories.add(latestDeal);
      this.myFilteredCategories.add(latestDeal);
    }
    print("Kill me");
    notifyListeners();
  }

  void changeCategory(query) {
    print("q: $query");

    this.myFilteredCategories.clear();
    myCategories.forEach(
      (element) {
        print(element);
        if (element.name.toLowerCase().contains(query.toLowerCase())) {
          this.myFilteredCategories.add(element);
        }
      },
    );

    notifyListeners();
  }

  void addMainForum(List<DealsModel> forums) {
    print("wtf");
    for (var latestDeal in forums) {
      this.myMainForums.add(latestDeal);
      this.myFilteredMainForums.add(latestDeal);
    }
    print("Kill me");
    notifyListeners();
  }

  void changeMainForum(query) {
    print("q: $query");

    this.myFilteredMainForums.clear();
    myForums.forEach(
      (element) {
        print(element);
        if (element.deal_title.toLowerCase().contains(query.toLowerCase())) {
          this.myFilteredMainForums.add(element);
        }
      },
    );

    notifyListeners();
  }

  void addNotification(List<NotificationModel> forums) {
    print("wtf");
    for (var latestDeal in forums) {
      this.myNotifications.add(latestDeal);
      this.myFilteredNotifications.add(latestDeal);
    }
    print("Kill me");
    notifyListeners();
  }

  void changeNotification(query) {
    print("q: $query");

    this.myFilteredNotifications.clear();
    myNotifications.forEach(
      (element) {
        print(element);
        if (element.type.toLowerCase().contains(query.toLowerCase())) {
          this.myFilteredNotifications.add(element);
        }
      },
    );

    notifyListeners();
  }

  void addSaved(List<SavedModel> forums) {
    print("wtf");
    for (var latestDeal in forums) {
      this.mySaved.add(latestDeal);
      this.myFilteredSaved.add(latestDeal);
    }
    print("Kill me");
    notifyListeners();
  }

  void changeSaved(query) {
    print("q: $query");

    this.myFilteredSaved.clear();
    mySaved.forEach(
      (element) {
        print(element);
        if (element.title.toLowerCase().contains(query.toLowerCase())) {
          this.myFilteredSaved.add(element);
        }
      },
    );

    notifyListeners();
  }

  void addHistory(List<HistoryModel> forums) {
    print("wtf");
    for (var latestDeal in forums) {
      this.myHistory.add(latestDeal);
      this.myFilteredHistory.add(latestDeal);
    }
    print("Kill me");
    notifyListeners();
  }

  void changeHistory(query) {
    print("q: $query");

    this.myFilteredHistory.clear();
    myHistory.forEach(
      (element) {
        print(element);
        if (element.title.toLowerCase().contains(query.toLowerCase())) {
          this.myFilteredHistory.add(element);
        }
      },
    );

    notifyListeners();
  }

  void addOldDiscussion(List<DiscussionModel> forums) {
    print("wtf");
    for (var latestDeal in forums) {
      this.myOldDiscussion.add(latestDeal);
      this.myFilteredOldDiscussion.add(latestDeal);
    }
    print("Kill me");
    notifyListeners();
  }

  void changeOldDiscussion(query) {
    print("q: $query");

    this.myFilteredOldDiscussion.clear();
    myOldDiscussion.forEach(
      (element) {
        print(element);
        if (element.subject.toLowerCase().contains(query.toLowerCase())) {
          this.myFilteredOldDiscussion.add(element);
        }
      },
    );

    notifyListeners();
  }

  void addNewDiscussion(List<DiscussionModel> forums) {
    print("wtf");
    for (var latestDeal in forums) {
      this.myNewDiscussion.add(latestDeal);
      this.myFilteredNewDiscussion.add(latestDeal);
    }
    print("Kill me");
    notifyListeners();
  }

  void changeNewDiscussion(query) {
    print("q: $query");

    this.myFilteredNewDiscussion.clear();
    myNewDiscussion.forEach(
      (element) {
        print(element);
        if (element.subject.toLowerCase().contains(query.toLowerCase())) {
          this.myFilteredNewDiscussion.add(element);
        }
      },
    );

    notifyListeners();
  }
}
