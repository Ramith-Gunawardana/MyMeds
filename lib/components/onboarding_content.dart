class UnbordingContent {
  String image;
  String title;
  String description;

  UnbordingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Never forget your medicine again!',
      image: 'lib/assets/icons/1.gif',
      description:
          "Remember what to take, when to take, when to refill. Never miss a dose again."),
  UnbordingContent(
      title: 'Multiple users & multiple devices at the same time!',
      image: 'lib/assets/icons/2.gif',
      description:
          "No matter where you are, you can always access your medicine schedule. Sync your medication shedule across all your devices."),
  UnbordingContent(
      title: 'Find the best and nearest services!',
      image: 'lib/assets/icons/3.gif',
      description:
          "Find the nearest helpline with ease. Find the nearest hospital and pharmacy. All on your fingertips"),
  UnbordingContent(
      title: 'Track your progress!',
      image: 'lib/assets/icons/4.gif',
      description:
          "Take control of your medication. Never miss a dose again. Stay organized. Stay healthy!"),
];
