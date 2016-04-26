package grockScala.errorhandling

/** Implement Option ADT to handle error conditons */
sealed trait Option[+A] {

  def map[B](f: A => B): Option[B] = this match {
    case Some(a) => Some(f(a))
    case None => None
  }

  /** Apply f, which may fail, to the Option, if not none */
  def flatMap[B](f: A => Option[B]): Option[B] = this match {
    case Some(a) => f(a)
    case None => None
  }

  /** Return value, if None return default, default nonstrict */
  def getOrElse[B >: A](default: => B): B = this match {
    case Some(a) => a
    case None => default
  }

  /** If None, swap with superclass Option, nonstrictly */
  def orElse[B >: A](default: => Option[B]): Option[B] =
    if (this == None) default
    else this

  /** Convert Some to None if predicate false */
  def filter(pred: A => Boolean): Option[A] = 
    flatMap((a: A) =>
      if (pred(a)) this
      else None
    )

// Versions from book answers
  /** Apply f, which may fail, to the Option, if not none */
  def flatMap_book[B](f: A => Option[B]): Option[B] = 
    map(f).getOrElse(None)

  /** Convert Some to None if predicate false */
  def filter2(pred: A => Boolean): Option[A] = 
    flatMap_book((a: A) =>
      if (pred(a)) this
      else None
    )

  /** If None, swap with superclass Option, nonstrictly */
  def orElse_book[B >: A](default: => Option[B]): Option[B] =
    map(Some(_)).getOrElse(default)

}
case class Some[+A](get: A) extends Option[A]
case object None extends Option[Nothing]

