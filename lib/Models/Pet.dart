class Pet {
  final String image,
      name,
      species,
      foodType,
      ownerName,
      ownerPhoneNumber,
      dateEntry,
      dateExit;
  final int id, sex, age, enclosure;

  Pet({
    this.image,
    this.name,
    this.sex,
    this.species,
    this.age,
    this.enclosure,
    this.foodType,
    this.ownerName,
    this.ownerPhoneNumber,
    this.dateEntry,
    this.dateExit,
    this.id,
  });
}

List<Pet> pets = [
  Pet(
    image: "assets/images/black-doggo.jpg",
    name: "Dark Doggo",
    sex: 1,
    species: "dog",
    age: 2,
    enclosure: 1,
    foodType: "Dog Food",
    ownerName: "Jessica Walmart",
    ownerPhoneNumber: "0645342314",
    dateEntry: "30/12/2020",
    dateExit: "03/01/2021",
    id: 1,
  ),
  Pet(
    image: "assets/images/carpet-dog.jpg",
    name: "Carpet Dog",
    sex: 0,
    species: "dog",
    age: 2,
    enclosure: 2,
    foodType: "Dog Food",
    ownerName: "Louis Lefun",
    ownerPhoneNumber: "0645342678",
    dateEntry: "30/12/2020",
    dateExit: "09/01/2021",
    id: 2,
  ),
  Pet(
    image: "assets/images/kakapo.jpg",
    name: "Step Kakapo",
    sex: 0,
    species: "kakapo",
    age: 4,
    enclosure: 3,
    foodType: "Grains",
    ownerName: "Antonio Meh",
    ownerPhoneNumber: "0645342670",
    dateEntry: "29/12/2020",
    dateExit: "03/01/2021",
    id: 3,
  ),
  Pet(
    image: "assets/images/kangoo.jpg",
    name: "Dababy",
    sex: 1,
    species: "kangaroo",
    age: 4,
    enclosure: 4,
    foodType: "Herb",
    ownerName: "Marie Blachere",
    ownerPhoneNumber: "0645342871",
    dateEntry: "29/12/2020",
    dateExit: "10/01/2021",
    id: 4,
  ),
  Pet(
    image: "assets/images/long-hair-cat.jpg",
    name: "Britney",
    sex: 1,
    species: "cat",
    age: 6,
    enclosure: 5,
    foodType: "cat food",
    ownerName: "Dany Boon",
    ownerPhoneNumber: "0655342871",
    dateEntry: "30/12/2020",
    dateExit: "14/01/2021",
    id: 5,
  ),
  Pet(
    image: "assets/images/soul-staring-cat.jpg",
    name: "Jack",
    sex: 1,
    species: "cat",
    age: 10,
    enclosure: 6,
    foodType: "Cat food",
    ownerName: "Dany DeVito",
    ownerPhoneNumber: "0655342871",
    dateEntry: "30/12/2020",
    dateExit: "30/01/2021",
    id: 6,
  ),
];
