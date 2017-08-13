<?php

namespace AppBundle\Entity;

use ApiPlatform\Core\Annotation\ApiResource;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * A Team of a Customer.
 *
 * @ApiResource(itemOperations={
 *     "get"={"method"="GET"},
 *     "put"={"method"="PUT"}
 * })
 * @ORM\Entity
 */

class Team
{
    /**
     * @var int The id of this team.
     * 
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @var string The name of this team.
     * 
     * @ORM\Column
     * @Assert\NotBlank
     */
    private $name;

    /**
     * @var int The status of this team.
     * 0 = Deleted
     * 1 = Active
     * 2 = Inactive
     * 
     * @ORM\Column(type="smallint")
     * @Assert\Range(min=0, max=2)
     * @Assert\NotNull
     */
    private $status;

    /**
     * @var Customer The customer (owner) of this team.
     * 
     * @Assert\NotNull
     * @ORM\ManyToOne(targetEntity="Customer", inversedBy="teams")
     */
    private $customer;

    /**
     * @var User[] Users which belong to this team.
     *
     * @ORM\OneToMany(targetEntity="User", mappedBy="team")
     */
    private $users;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->users = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set name
     *
     * @param string $name
     *
     * @return Team
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set status
     *
     * @param integer $status
     *
     * @return Team
     */
    public function setStatus($status)
    {
        $this->status = $status;

        return $this;
    }

    /**
     * Get status
     *
     * @return integer
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * Set customer
     *
     * @param \AppBundle\Entity\Customer $customer
     *
     * @return Team
     */
    public function setCustomer(\AppBundle\Entity\Customer $customer = null)
    {
        $this->customer = $customer;

        return $this;
    }

    /**
     * Get customer
     *
     * @return \AppBundle\Entity\Customer
     */
    public function getCustomer()
    {
        return $this->customer;
    }

    /**
     * Add user
     *
     * @param \AppBundle\Entity\User $user
     *
     * @return Team
     */
    public function addUser(\AppBundle\Entity\User $user)
    {
        $this->users[] = $user;

        return $this;
    }

    /**
     * Remove user
     *
     * @param \AppBundle\Entity\User $user
     */
    public function removeUser(\AppBundle\Entity\User $user)
    {
        $this->users->removeElement($user);
    }

    /**
     * Get users
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getUsers()
    {
        return $this->users;
    }
}
