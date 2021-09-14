import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';
import 'package:seriousfocus/service/learning_firebase_service.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:seriousfocus/widgets/learning/learning_flipcard.dart';
import 'package:card_swiper/card_swiper.dart';

// ignore: must_be_immutable
class LearningFlashcards extends StatefulWidget {
  final String categoryName;
  final List<LearningFlashcardModel> flashcards;
  final LearningFlashcardModel initialFlashCard;
  late int initialFlashcardIndex;
  late SwiperController _pageController;
  late SwiperControl _paginationController;
  late int _currentIndex;

  LearningFlashcards({
    Key? key,
    required this.categoryName,
    required this.flashcards,
    required this.initialFlashCard,
  }) : super(key: key) {
    initialFlashcardIndex = flashcards.indexOf(initialFlashCard);
    LearningFlashcardModel firstFlashcard =
        flashcards.removeAt(initialFlashcardIndex);
    flashcards.insert(0, firstFlashcard);

    _pageController = new SwiperController();
    _pageController.index = 0;
    _currentIndex = _pageController.index!;
    _paginationController = SwiperControl();
  }

  @override
  _LearningFlashcardsState createState() => _LearningFlashcardsState();
}

class _LearningFlashcardsState extends State<LearningFlashcards> {

  void _navigateToNextPage(){
    widget._pageController.next();
  }

  void _nextPageAndStatusUpdate(int currentPage, int newStatus) async {
    LearningFlashcardModel updatedCard = await LearningService().setFashcardsLearningStatus(widget.flashcards[currentPage].documentID!, newStatus);
    Future.delayed(Duration(milliseconds: 250));
    setState(() {
      widget.flashcards[currentPage] = updatedCard;
      widget._pageController.index = currentPage;
    });
    _navigateToNextPage();
  }

  Container _statusBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 5.0,
            spreadRadius: 5.0,
            offset: Offset(0, -1.5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _statusButton(
            FontAwesomeIcons.frown, 
            () => _nextPageAndStatusUpdate(widget._currentIndex, 1), 
            Colors.red,
          ),
          _statusButton(
            FontAwesomeIcons.meh,
            () => _nextPageAndStatusUpdate(widget._currentIndex, 2), 
            Colors.yellow[700]!,
          ),
          _statusButton(
            FontAwesomeIcons.smileBeam,
            () => _nextPageAndStatusUpdate(widget._currentIndex, 3), 
            Colors.green,
          ),
          _statusButton(
            FontAwesomeIcons.chevronRight,
            () {
              _navigateToNextPage();
            },
            Colors.grey,
          ),
        ],
      ),
    );
  }

  TextButton _statusButton(IconData icon, Function onTap, Color color){
    return TextButton(
      onPressed: () => onTap(), 
      style: TextButton.styleFrom(
        minimumSize: Size(75, 50),
        primary: color,
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: color
      ),
      child: Container(
        child: FaIcon(
          icon,
          color: color,
        ),
      )
    );
  }

  Swiper _bodyList(BuildContext ctx) {
    return Swiper(
      controller: widget._pageController,
      itemCount: widget.flashcards.length,
      itemWidth: MediaQuery.of(ctx).size.width * 0.95,
      layout: SwiperLayout.STACK,
      onIndexChanged: (index){
        setState(() {
          widget._currentIndex = index;
        });
      },
      itemBuilder: (context, index) {
        return LearningFlipcard(model: widget.flashcards[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
        showAppBar: true,
        title: widget.categoryName,
        body: _bodyList(context),
        bottomNavigationBar: _statusBar());
  }
}
