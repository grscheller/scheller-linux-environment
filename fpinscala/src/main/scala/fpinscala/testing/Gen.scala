/** Property based testing package.
 *
 *   A library modeled after ScalaCheck's
 *   interface and behavior.  ScalaCheck itself
 *   is modeled after Haskell's QuickCheck.
 *
 */
package fpinscala.testing

import fpinscala.state.rand.{Rand,RNG,LCG}
import Prop._
import Gen._

trait Prop {
  def check: Either[(FailedCase, SuccessCount), SuccessCount]
}

object Prop {
  type FailedCase = String
  type SuccessCount = Int
}

case class Gen[A](sample: Rand[A]) {

  def map[B](f: A => B): Gen[B] = Gen(sample map f)

  def flatMap[B](g: A => Gen[B]): Gen[B] =
    Gen(sample.flatMap(a => g(a).sample))

}

object Gen {

  /** A "lazy" unit which always generates the same value. */
  def unit[A](a: => A): Gen[A] = Gen(Rand.unit(a))

  def choose(start: Int, stopExclusive: Int): Gen[Int] =
    Gen(Rand.exclusiveIntRange(start, stopExclusive))

  def listOfN[A](n: Int, g: Gen[A]): Gen[List[A]] =
    Gen(Rand.sequence(List.fill(n)(g.sample)))

  def boolean: Gen[Boolean] = Gen(Rand.boolean)

}

